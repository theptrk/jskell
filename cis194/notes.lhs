Haskell is:
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
Statically Typed
    But in a cool way

Basic Types: Int, Integer, Double, Float, Bool, Char, String
Basic Boolean Logic: &&, || work like JS but "not" is used to negate
if *expressions*: else is mandatory
    > if b then t else f

-- Crash your computer! :)
y :: Int
y = y + 4

Intro to Lists
    -- <Number|Char|List> : List
     > 'A': " DOG"
    "A DOG"

    -- <List> ++ <List>
   > [1,2,3] ++ [4,5,6]
    [1,2,3,4,5]

    -- <List> !! <Number>
    > []

Basic Functions:
    -- Single argument
    doubleMe x = x + x

    -- Double argument
    doubleUs x y = x*2 + y*2
    -- OR
    doubleUs x y = doubleMe x + doubleMe y

    -- Matching
    sumtorial :: Integer -> Integer
    sumtorial 0 = 0
    sumtorial n = n + sumtorial (n-1)

    -- Guards
    isEven :: Integer -> Bool
    isEven n
      |  n `mod` 2 == 0 = True
      |  otherwise      = False

