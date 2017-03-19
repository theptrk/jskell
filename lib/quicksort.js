// quicksort.js
const quicksort = function(arr) {
  if (arr.length === 0) {
    return [];
  }
  const [pivot, ...xs] = arr;
  const smallerSorted = quicksort(xs.filter((val) => {
    return val <= pivot;
  }));
  const biggerSorted = quicksort(xs.filter((val) => {
    return val > pivot;
  }));
  return smallerSorted.concat(pivot).concat(biggerSorted);
};

module.exports = quicksort;
