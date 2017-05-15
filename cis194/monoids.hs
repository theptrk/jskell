-- # Monoids
-- monoid is when you have an associative binary function and a value which
-- acts as an identity with respect to that function
class Monoid m where -- m is a concrete type
  mempty :: m -- mempty is a polymorphic constant
  mappend :: m -> m -> m
  mconcat :: [m] -> m
  mconcat = foldr mappend mempty -- this is the default implementation

-- monoid laws:
-- if mempty, mappend defaults to other value
-- 1. mempty `mappend` x = x
-- 2. x `mappend` mempty = x
mappend mempty x = x
mappend x mempty = x
-- 3. (x `mappend` y) `mappend` z = x `mappend` (y `mappend` z) -- (associative)
-- mappend x (mappend y z) = mappend (mappend x y) z
-- mconcat uses foldr with the mappend function with an mempty starting value
mconcat = foldr mappend mempty

-- Lists are monoids
instance Monoid [a] where
  mempty = []
  mappend = (++)

mappend [1,2] [3,4]
-- [1,2,3,4]
[1,2] `mappend` [3,4] `mappend` [5,6]
-- [1,2,3,4,5,6]
[1,2] `mappend` mempty
-- [1,2]
--
-- Because mconcat has a default implementation, we get it for free when we
-- make something an instance of Monoid, remember it is "foldr mappend mempty"
mconcat [[1,2], [3,5], [9]]
-- [1,2,3,5,9]

-- But what about numbers where our mconcat should maybe multiply, maybe add?
-- These are only for learning purposes; you can just * or +
-- use `newtype` to create Product
newtype Product a = Product { getProduct :: a }
  deriving (Eq, Ord, Read, Show, Bounded)

instance Num a => Monoid (Product a) where
  -- mempty is just 1 wrapped in a Product constructor
  mempty = Product 1
  -- pattern matches on the Product constructor
  Product x `mappend` Product y = Product (x * y)

-- vs. cis194
> newtype Product a = Product a
>   deriving (Eq, Ord, Num, Show)

> getProduct :: Product a -> a
> getProduct (Product a) = a

> instance Num a => Monoid (Product a) where
>   mempty = Product 1
>   mappend = (*)


-- how do we use it?
getProduct $ Product 3 `mappend` Product 9
-- 27
getProduct $ Product 3 `mappend` mempty
-- 3
getProduct . mconcat . map Product $ [3,4,2]
-- 24

-- use `newtype` to create Sum
newtype Sum a = Sum { getSum :: a }
  deriving (Eq, Ord, Read, Show, Bounded)

instance Num a => Mondoid (Sum a) where
  mempty = Sum 0
  Sum x `mappend` Sum y = Sum (x + y)

-- vs. cis194; which is better?
> newtype Sum a = Sum a
>   deriving (Eq, Ord, Num, Show)

> getSum :: Sum a -> a
> getSum (Sum a) = a

> instance Num a => Monoid (Sum a) where
>   mempty = Sum 0
>   mappend = (+)

getSum . mconcat . map Sum $ [1,2,3]
-- 6


-- Lets create a general purpose monoids `Any` and `All`
-- These are only for learning purposes; you can just || or &&
newtype Any = Any { getAny :: Bool }
  deriving (Eq, Ord, Read, Show, Bounded)

instance Monoid Any where
  mempty = Any False
  Any x `mappend` Any y = Any (x || y)

getAny $ Any True `mappend` Any False
-- True
getAny $ mempty `mappend` Any True
-- True
getAny . mconcat . map Any $ [False, False, True]
-- True

newtype All = All { getAll :: Bool }
  deriving (Eq, Ord, Read, Show, Bounded)

instance Monoid All where
  mempty = All True
  All x `mappend` All y = All (x && y)

getAll $ mempty `mappend` All True
-- True
getAll . mconcat . map All $ [True, True, True]
-- True
getAll . mconcat . map All $ [True, True, False]
-- False

-- The Ordering monoid
instance Monoid Ordering where
  mempty = EQ
  -- notice the three implementations here
  -- these are pattern matching instances
  LT `mappend` _ = LT
  EQ `mappend` y = y
  GT `mappend` _ = GT

-- here is a super confusing case for monoids
-- note that `compare` returns Ordering
--
-- version 1 without monoid functions
lengthCompare :: String -> String -> Ordering
lengthCompare x y = let a = length x `compare` length y
                        b = x `compare` y
                    in if a == EQ then b else a
-- version 2 with one monoid function use
lengthCompare :: String -> String -> Ordering
lengthCompare x y = (length x `compare` length y) `mappend`
                    (x `compare` y)
-- version 3 with more monoid function use
import Data.Monoid
-- see, look, just keep mappend'ing
lengthCompare :: String -> String -> Ordering
lengthCompare x y = (length x `compare` length y) `mappend`
                    (vowels x `compare` vowels y) `mappend`
                    (x `compare` y)
  where vowels = length . filter (`elem` "aeiou")

-- with the ordering monoid we can easily compare based on different criteria
-- and actually rank the comparisons themselves.

-- lets treat Maybe a as a monoid only if its type parameter a is a monoid
-- The Maybe monoid
instance Monoid a => Monoid (Maybe a) where
  mempty = Nothing
  Nothing `mappend` m = m
  m `mappend` Nothing = m
  Just m1 `mappend` Just m2 = Just (m1 `mappend` m2)

-- `mappend` strings will use the string monoid append
Nothing `mappend` Just "andy"
-- Just "andy"
Just "ter" `mappend` Just "rence"
-- Just "terrence"
--
Just LT `mappend` Nothing
-- Just LT
Nothing `mappend` Just LT
-- Just LT
--
-- if you `mappend` two Just a, then you use the `mappend` of a
Just (Sum 3) `mappend` Just (Sum 4)
-- Just (Sum {getSum = 7})

-- because of this instance we dont have to check if the computations have
-- failed by seeing if theyre a Nothing or Just value; we can just continue to
-- treat them as normal monoids

newtype First a = First { getFirst :: Maybe a }
  deriving (Eq, Ord, Read, Show)

instance Monoid (First a) where
  mempty = First Nothing
  First (Just x) `mappend` _ = First (Just x)
  First Nothing `mappend` x = x

getFirst $ First (Just 'a') `mappend` First (Just 'a')
-- Just 'a'
getFirst $ First Nothing `mappend` First (Just 'b')
-- Just 'b'
getFirst . mconcat . map First $ [Nothing, Just 9, Just 10]
-- Just 9


-- One of the more interesting ways to use monoids is to make them help us
-- define folds over various data structures
--
-- Foldable type class from Data.Foldable
import qualified Foldable as F

:t foldr
> foldr :: (a -> b -> b) -> b -> [a] -> b

:t F.foldr
> F.foldr :: (F.Foldable t) => (a -> b -> b) -> b -> t a -> b

-- remember our tree?
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

-- two ways to make something an instance of Foldable
-- 1. directly implement foldr for it
-- 2. implement the foldMap function
:i foldMap
class Foldable (t :: * -> *) where
  -- ...
  foldMap :: Monoid m => (a -> m) -> t a -> m
  -- ...
    -- Defined in ‘Data.Foldable’

:t foldMap
> foldMap :: (Monoid m, Foldable t) => (a -> m) -> t a -> m
-- parameter 1: function that takes value of the type our Foldable contains
--  and returns a monoid value
-- parameter 2: foldable structure that contains values of type a
--
-- foldMap
-- 1. maps the function over the foldable structure
-- 2. produces a foldable structure of monoids
-- 3. mappends all monoids into a single monoid value
--
-- this is how we make Tree an instance of Foldable
instance F.Foldable Tree where
  foldMap f Empty = mempty
  foldMap f (Node x l r) = F.foldMap f l `mappend`
                           f x           `mappend`
                           F.foldMap f r

-- note from community: AVOID POPULARITY AT ALL COSTS
-- example: classes and instances are NOT RELATED to classes and instances in OOP
-- Taking from Rust:
  -- typeclasses should be called Traits
  -- instances should be called Implementations
