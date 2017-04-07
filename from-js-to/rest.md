# rest operators
haskell has syntax (:) that allows pattern matching to get
the tail of a list. ES6 introduces the "rest operator"
to get the tail of an array with `...variablename`

```javascript
// This is a normal destructoring assignement *without* a rest operator
var letters = ['x', 'y', 'z'];
var [x, others] = letters;
console.log(x);
// 'x'
console.log(others);
// 'y'

// This is destructoring *with* a rest operator
var letters = ['x', 'y', 'z'];
var [x, others] = letters;
console.log(x);
// 'x'
console.log(others)
// ['y', 'z']
```

## maximum in haskell
```haskell
-- max in haskell
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)
```
## maximum in javascript
```javascript
var maximum = function(list) {
    const [x, xs] = list;
    if (list.length === 0) {
        throw Error('maximum of empty list');
    }
    if (list.length === 1) {
        return list;
    }
    return Math.max(x, maximum(xs));
};
```
