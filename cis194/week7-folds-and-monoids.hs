-- Week 7
-- # Folds and Monoids
--
-- src: learn you a haskell
-- fold takes a binary function, a starting value and a list to fold up
sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

-- :t foldl
-- foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b

-- also valid sum using foldl
sum'' :: (Num a) => [a] -> a
sum'' = foldl (+) 0

-- (\acc x -> acc + x) is the same as (+)
-- sum' = foldl (\acc x -> acc + x) 0 -- also works

elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldl (\acc x -> if x == y then True else acc) False ys

-- map with foldr
map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs

-- map with foldl is inefficient because ++ is more expensive than :
-- map'' :: (a -> b) -> [a] -> [b]
-- map'' f xs = foldl (\acc x -> acc ++ [f x]) [] xs

maximum' :: (Ord a) => [a] -> a
maximum' = foldr1 (\x acc -> if x > acc then x else acc)

reverse' :: [a] -> [a]
reverse' = foldl (\acc x -> x : acc) []

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x acc -> if p x then x:acc else acc) []

-- scans are like folds but they report intermediate accumulator states in the
-- form of a list
scanl (+) 0 [3,5,2,1]
-- [0,3,8,10,11]

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
-- 3. (x `mappend` y) `mappend` z = x `mappend` (y `mappend` z) -- (associative)

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

-- What if we wanted our numbers to be monoids?
-- multiplication: * is our binary function and the identity value is 0
-- addition: + is our binary function and the identity value is 0
--
-- Product is defined like this
newtype Product a = Product { getProduct :: a }
  deriving (Eq, Ord, Read, Show, Bounded)

-- Product a is an instance of Mondoid for all a's that are an instance of Num
instance Num a => Monoid (Product a) where
  -- empty is 1 wrapped in a Product constructor
  mempty = Product 1
  -- mappend pattern matches on the Product constructor
  Product x `mappend` Product y = Product (x * y)

-- to use Product a as a monoid
getProduct $ Product 3 `mappend` mempty
getProduct $ Product 3 `mappend` Product 9
getProduct $ Product 3 `mappend` Product 9 `mappend` Product 2

-- What is "newtype"?
-- a newtype delcatration creates a new type in much the same way as `data`
-- however, there is a restriction to one constructor with on field
-- also, record syntax is still allowed but only for one field
-- `newtype State s a = State { runState :: s -> (s, a)}`
-- more info: https://wiki.haskell.org/Newtype

