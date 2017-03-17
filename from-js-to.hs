-- GOTCHAS
-- if requires a Boolean in Haskell; not just a truthy or falsey value
-- everything is an expression 
--
-- quicksort.js
-- const quicksort = function(arr) {
--   if (arr.length === 0) {
--     return [];
--   }
--   const [pivot, ...xs] = arr;
--   const smallerSorted = quicksort(xs.filter((val) => {
--     return val <= pivot;
--   }));
--   const biggerSorted = quicksort(xs.filter((val) => {
--     return val > pivot;
--   }));
--   return smallerSorted.concat(pivot).concat(biggerSorted);
-- };

-- quicksort.hs
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
  let smallerSorted = quicksort [a | a <- xs, a <= x]
      biggerSorted = quicksort [a | a <- xs, a > x]
  in smallerSorted ++ [x] ++ biggerSorted
