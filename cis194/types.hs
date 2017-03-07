-- ADT
-- template:
data <type> = <data_constructors> | ...

-- Bool
data Bool = True | False
:type True
--> True :: Bool

-- most basic definition
data Trivial = Trivial'
:type Trivial'
--> Trivial' :: Trivial
-- Note that Trivial is the type
:type Trivial
--> <interactive>:1:1: error:
-->   • Data constructor not in scope: Triv
-->       • Perhaps you meant ‘Triv'’ (line 1)


-- template - data contructors can take values
data AlgDataType = Contr1 Value11 Value12
                 | Contr2 Value21
                 | Contr3

data Thing = Shoe | King
data Person = Person String Int Thing
  deriving Show

brent :: Person
brent = Person "Brent" 31 King

-- pattern matching
baz :: Person -> String
baz p@(Person n _ _ ) = "The name is(" ++ show p ++ ") is " n
-- note that p is the entire value while n is the first argument
--


Inferred Types:
-- type signatures can be nested
> :type [[True], [False, False]]
> [[True], [False, False]] :: [[Bool]]

-- types will be inferred
-- inferred [Char]
> :type [(True, []), (False, [['a']])]
> [(True, []), (False, [['a']])] :: [(Bool, [[Char]])]

-- inferred Char
> :type [(True, []), (False, ['a'])]
[(True, []), (False, ['a'])] :: [(Bool, [Char])]

-- inferred [Char]
> :type [(True, []), (False, ["a"])]
> [(True, []), (False, ["a"])] :: [(Bool, [[Char]])]


