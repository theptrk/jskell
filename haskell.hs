-- # lists
-- ## pattern matching
-- ### (:)
head' :: [a] -> a
head' [] = error "empty list!"
head' (x:_) = x

tail' :: [a] -> a
tail' [] = error "empty list!"
tail' [a] = error "no tail!"
tail' (_:xs) = xs
