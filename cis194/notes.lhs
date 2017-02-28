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
if *expressions*:
-- if <Boolean> then <expression with type a> else <expression with type a>
-- else is mandatory
> if b then t else f
-- can be multi-lines if any amount of indentation is used
> if b
>   then t
>   else f

Intro to Lists:
Elements must be the same type

> :type (:) -- special infix operator
> (:) :: a -> [a] -> [a]
--
> 'A': " DOG"
> "A DOG"

> :type (++) -- special infix operator
> (++) :: [a] -> [a] -> [a]
--
> [1,2,3] ++ [4,5,6]
> [1,2,3,4,5]

> :type (!!) -- special infix operator
> (!!) :: [a] -> Int -> a
--
> [1,2,3] !! 0
> 1 -- index starts at 0

-- null <- identifies an empty list
> :type null
> null :: [a] -> Bool

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

More on Types:
type signatures can be nested
> :type [[True], [False, False]]
> [[True], [False, False]] :: [[Bool]]

types will be inferred
-- inferred [Char]
> :type [(True, []), (False, [['a']])]
> [(True, []), (False, [['a']])] :: [(Bool, [[Char]])]

-- inferred Char
> :type [(True, []), (False, ['a'])]
[(True, []), (False, ['a'])] :: [(Bool, [Char])]

-- inferred [Char]
> :type [(True, []), (False, ["a"])]
> [(True, []), (False, ["a"])] :: [(Bool, [[Char]])]

tuples are not enumerable

thunks are deferred expressions

functions are polymorphic when it has type variables that can be any type
>:type last
>last :: [a] -> a

parametric polymorphism - a haskell type can have parameters that later bind to
other types
> last "something"
-- the compiler substitutes [Char] for each a in the type signature
-- the type can then be read as [Char] -> Char
