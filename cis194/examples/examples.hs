add a b = a + b

mydrop n xs = if n <= 0 || null xs
  then xs
  else mydrop (n-1) (tail xs)

data Thing = Shoe | King
  deriving Show
data Person = Person String Int Thing
  deriving Show

brent :: Person
brent = Person "Brent" 31 King

data IntList = Empty | Cons Int IntList

intListProd :: IntList -> Int
intListProd Empty = 1
intListProd (Cons x 1) = x * intListProd 1

data Tree = Leaf Char
          | Node Tree Int Tree
  deriving Show

tree :: Tree
tree = Node (Lead 'x') 1 (Node (Left 'y') 2 (Leaf 'z'))
