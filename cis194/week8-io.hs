-- the problem with purity
-- 1 functions may not have side effects
-- 2 functions may not dpeend on external "stuff" - cant read from the file
-- system, keyboard or network

-- The IO Type
-- IO a are descriptions of effectful computations but they are ITSELF, NOT

-- haskell compiler looks for
main :: IO ()

-- example hello.hs program
-- putStrLn :: String -> IO ()
main = putStrLn "Hello, Haskell"

-- "and then" (>>)
(>>) :: IO a -> IO b -> IO b

-- example with >>
main = putStrLn "Hello" >> putStrLn "world!"

-- "bind" (>>=)
(>>=) :: IO a -> (a -> IO b) -> IO b

-- example with >>=
main :: IO ()
main = putStrLn "Please enter a number: " >> (readLn >>= (\n -> putStrLn (show (n + 1))))
