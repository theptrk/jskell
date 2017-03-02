// Every function in Haskell officially only takes one parameter.
// In haskell functions may be defined as taking more than one argument
// but when the first argument is applied, this returns a partially applied
// function. The second argument being applied may also return a partially
// applied function until the value is returned
// >1 arguments returns a curried function!

#What is a partially applied function?
- Say a function takes two arguments, a city and a travel tip;
```javascript
node> var traveltips = (city, tip) => city + " " + tip;
```
```haskell
ghci> traveltips city tip = city ++ " " ++ tip;
```
- We can fully apply the functions like so
```javascript
node> traveltips("taipei", "soy milk king has the best soy milk")
> "taipei soy milk king has the best soy milk"
```
```haskell
ghci> traveltips "taipei" "soy milk king has the best soy milk"
> "taipei soy milk king has the best soy milk"
```
- But what if we want to apply less than all arguments?
- lets bind only one argument
```javascript
node> var travelTipsAboutTaipei = traveltips.bind(null, "taipei")
// this function now has "taipei" bound as the `city` parameter
node> travelTipsAboutTaipei("has incredible shaved ice")
> "taipei has incredible shaved ice"
```
```haskell
ghci> travelTipsAboutTaipei = traveltips "taipei"
ghci> travelTipsAboutTaipei("has incredible shaved ice")
-- this function now has "taipei" bound as the `city` parameter
> "taipei has incredible shaved ice"
```


```haskell
ghci> max 4 5
> 5
-- is the same as
ghci> (max 4) 5
> 5
-- 1. always partiallay applied functions
-- 2.  2. left associative function application

-- this makes it very easy to create a partially applied function
ghci> maxOf4OrSomethingElse = max 4
ghci> maxOf4OrSomethingElse 5
> 5

> :t max
> max :: Ord a => a -> a -> a
-- the above can be thought of as
> max :: Ord a => a -> (a -> a)
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
