-- 1 find the last element of a list
-- > myLast [1,2,3,4]
-- 4
-- > myLast ['x', 'y', 'z']
-- 'z'
myLast :: [a] -> a
myLast [] = error "No last element of empty list"
myLast [x] = x
myLast (_: xs) = myLast xs

-- 2 find the last but one element of a list
myButLast :: [a] -> a
myButLast [] = error "No last but one element of empty list"
myButLast [x] = error "No last but of one element list"
myButLast [x, _] = x
myButLast (_:xs) = myButLast xs

-- 3 find the kth element of a list. the first element is number 1
elementAt :: [a] -> Integer -> a
elementAt (x: _) 1 = x
elementAt [] _ = error "cant do empty list"
elementAt (_:xs) k
  | k < 1 = error "k too small"
  | otherwise = elementAt xs (k-1)

elementAt' xs n
  | length xs < n = error "Index out of bounds"
  | otherwise = fst . last $ zip xs [1..n]

-- 4 find the number of elements in a list
myLength :: [a] -> Integer
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

