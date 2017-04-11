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
