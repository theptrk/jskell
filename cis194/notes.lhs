# Haskell is:
Functional
    Functions are first class
    Functions are values that are used as any other value
    We evaluate expressions instead of instructions
    * There is no precise accepted meaning of for the term "functional"
Pure
    No mutations and expressions never have side effects
    Same input => Same output
    Leads to Equational reasoning and refactoring
Lazy
    Expressions are not evaluated until needed
Strongly Typed
    strong, static and automatically inferred
    does *not* coerce a value like C can coerce an `int` to `float`
    static as in the compiler knows the type of every value at compile time

Basic Types: Int, Integer, Double, Float, Bool, Char, String
Basic Boolean Logic:
    &&, || are "and" and "or"
    "not" is used to negate ("not False")
Basic Variables:
    variables are immutably bound to an expression
    think of "=" as definition and NOT assignment to memory

if then else:
-- if <Boolean> then <expression with type a> else <expression with type a>
-- else is mandatory
> if b then t else f
-- can be multi-lines if any amount of indentation is used
> if b
>   then t
>   else f

# intro to Lists:
elements must be the same type
> :type (:) -- special infix operator
> (:) :: a -> [a] -> [a]
-- use
> 'A': " DOG"
> "A DOG"

> :type (++) -- special infix operator
> (++) :: [a] -> [a] -> [a]
-- use
> [1,2,3] ++ [4,5,6]
> [1,2,3,4,5]

> :type (!!) -- special infix operator
> (!!) :: [a] -> Int -> a
-- use
> [1,2,3] !! 0
> 1 -- index starts at 0

-- null <- function that identifies an empty list
> :type null
> null :: [a] -> Bool

> take 5 $ cycle [1,2,3]
> [1,2,3,1,2]

> take 10 (repeat 5)
> [5,5,5,5,5,5,5,5,5,5]

> zip [1,2,3,4,5] ["a", "b", "c"]
> [(1, "a"), (2, "b"), (3, "c")]

> zip [1..] ["apple", "orange", "cherry", "mango"
> [(1,"apple"),(2,"orange"),(3,"cherry"),(4,"mango")]

# list comprehensions
-- [<returnValue> | <operatingValue> <- List, <predicate>]

> [x*2 | x <- [1..10]]
> [2,4,6,8,10,12,14,16,18,20]

> [x*2 | x <- [1..10], x*2 >= 12]
> [12,14,16,18,20]


# basic Functions:
-- Single argument
> doubleMe x = x + x
-- Double argument
> doubleUs x y = x*2 + y*2
-- OR
> doubleUs x y = doubleMe x + doubleMe y

-- Matching
> sumtorial :: Integer -> Integer
> sumtorial 0 = 0
> sumtorial n = n + sumtorial (n - 1)

-- Guards
> isEven :: Integer -> Bool
> isEven n
>   |  n `mod` 2 == 0 = True
>   |  otherwise      = False

* tuples are not enumerable
* thunks are deferred expressions thanks to laziness

you cannot assign a value to something twice; this errors on compile time
> x = 10
> x = 11

functions are polymorphic when it has type variables that can be any type
"a" is a type variable which can stand for any type
> a -> a -> a

the "caller" of a polymorphic function gets to choose its type
this does not type check because the "implementer" cannot :
remember: :i && is Bool -> Bool -> Bool and we have not declared "a" Bool
> f :: a -> a -> a
> f x y = x && y

> :type last
> last :: [a] -> a

parametric polymorphism
-- a haskell type can have parameters that later bind to
other types
> last "something"
-- the compiler substitutes [Char] for each a in the type signature
-- the type can then be read as [Char] -> Char
> last [1,2,3,4,5]
-- the compiler substitutes [Int] for each a in the type signature
-- the type can then be read as [Int] -> Int

# intro to types:
> data BookInfo = Book Int String [String]
>                 deriving (Show)
-- type constructor: BookInfo
-- value constructor: Book
-- components/fields: Int String [String]
-- *usually type constructor and value constructor will be the same name

-- instances are created by using Book as we use functions
> myBook = Book 12345 "Algebra of Programming" ["Richard Bird", "Oege de Moor"]

-- check type of myBook
> :type myBook
-> myBook :: BookInfo

-- check type of Book
> :type Book
> Book :: Int -> String -> [String] -> BookInfo

-- type synonyms are used to make code more readable
> type CustomerId = Int
> type ReviewBody = String
-- we can use these type synonyms as datatypes in our definition
> data BookReview = BookReview BookInfo CustomerId ReviewBody

-- check the type of BookReview; per convention the value and type constructor
-- convention: the value and type constructor have the same name
> BookReview :: BookInfo -> CustomerId -> ReviewBody -> BookReview

-- we can pattern match in functions to extract values we need
> bookReviewCustomerId (BookReview bookInfo' custId' reviewBody') = custId'
> bookReviewReviewBody (BookReview bookInfo' custId' reviewBody') = reviewBody'

> :type bookReviewCustomerId
-> bookReviewCustomerId :: BookReview -> CustomerId
-- this function returns the CustomerId of the passed in BookReview argument
-- we pattern matched and specified which value to extract from `BookReview`

-- (==) can only be used on the same types
-- say we have two types Forwards and Backwards
> data Forwards = Forwards "String" "String" deriving (Eq)
> data Backwards = Backwards "String" "String" deriving (Eq)
> a = Forwards "AAA" "ZZZ"
> b = Backwards "AAA" "ZZZ"
> a == b
-- returns a type error

-- Haskell's take on enums
> data Lights = Red
>             | Yellow
>             | Green
>               deriving (Eq, Show)

> r = Red
> y = Yellow
> rr = Red
> r == y
-- False
> r == rr
-- True
> Red == Red
-- True


-- Maybe is super useful for safety
> data Maybe a = Nothing | Just a

-- this avoids crashes on empty or bad arguments
> head [] -- crashes
-- this never crashes
-- it gets the value from the Maybe or returns Nothing on an empty list
> safeHead :: [a] -> Maybe a
> safeHead [] = Nothing
> safeHead (x:_) = Just x

