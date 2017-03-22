// skips
// returns an array of arrays
// the first item is the same as the input
// the second item contains every 2nd item of the input
// the third item contains every 3rd item etc... until nth
//
// Example
// > skips(["A", "B", "C", "D"])
// [["A", "B", "C", "D"], ["B", "D"], ["C"], "[D]"]
//
// Note: this is different than the haskell example because haskell strings are
// actually lists of char and javascript strings are strings.
var skips = function(arr) {
  var newArr = [];
  arr.forEach(function(item, index){
    if(!newArr[index]) {
      newArr[index] = [];
    }
    var wipindex = index;
    while(wipindex < arr.length) {
      newArr[index].push(arr[wipindex]);
      wipindex = wipindex + index + 1;
    }
  });
  return newArr;
};

