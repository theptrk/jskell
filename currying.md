// Every function in Haskell officially only takes one parameter.
// One argument function applications to a function that requires
// >1 arguments returns a curried function!

```haskell
ghci> max 4 5
-- 5
ghci> (max 4) 5
-- 5
```

-- Take a look at this function that takes 3 parameters
multiplyThree :: (Num a) => a -> a -> a -> a
multiplyThree :: x y z = x * y * z

-- The type could also be written as
functionWithThreeParameters :: (Num a) => a -> (a -> (a -> a))

-- Step 1 this function takes a parameter and returns a function that
-- takes two additional parameters
functionWithTwoParameters :: (Num a) => a -> (a -> a)

-- Step 2 this function takes a parameter and returns a function that
-- takes one additional parameters
functionWithOneParameter :: (Num a) => a -> a

-- Step 3 this function takes a parameter and returns (:: Num a)
Num (a)


##How would we curry a function in javascript?

### example 1; closure keeps count
```javascript
function curry(fx) {
    // keep a count of the number of parameters
    const arity = fx.length

    return function f1() {
        // ES5 method of obtaining passed in arguments
        const args = Array.prototype.slice.call(arguments, 0);

        if(args.length >= arity) {
            return fx.apply(null, args);
        }
        else {
          return function f2() {
            const args2 = Array.prototype.slice.call(arguments, 0);
            return f1.apply(null, args.concat(args2));
          }
        }
    }
}
```
[source](http://blog.carbonfive.com/2015/01/14/gettin-freaky-functional-wcurried-javascript/
)
