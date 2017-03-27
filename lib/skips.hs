-- skips
-- returns an array of arrays
-- the first item is the same as the input
-- the second item contains every 2nd item of the input
-- the third item contains every 3rd item etc... until nth
--
-- Example
-- > skips "ABCD"
-- [["ABCD"], ["BD"], ["C"], [D]]
skips :: [a] -> [[a]]
skips xs =
  let pairToCount list = zip list [1.. length list]
      pairCounted = pairToCount xs
      filterByMod list modnum = [x | (x,y) <- pairCounted, mod y modnum == 0]
  in [filterByMod xs y | (_,y) <- pairCounted]


-- return subset of [a] in every multiple of n position
eachnth :: Int -> [a] -> [a]
eachnth _ [] = []
eachnth n (x:xs) = x : (eachnth n $ drop (n-1) xs)
-- this skips the first item create by (x: )
nth n xs = eachnth n $ drop (n-1) xs

skips2 xs =
  let indices = zip [1..] xs
      nth' (n, _) = nth n xs
  in map nth' indices
