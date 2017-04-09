// 1 find the last element of a list
const myLast = (list) => {
  const [x, y, ...z] = list;
  // list.length === 0
  if(x === undefined) {
    console.error("sorry empty array!");
    return null;
  }
  // list.length === 1 || list.length === 2
  if(z.length === 0) {
    return y || x;
  }
  // list.length > 2
  return myLast(list.slice(1));
};

// 2 find the last but one element of a list
const myButLast = (list) => {
  const [x, ...y] = list;
  if(x === undefined) {
    console.error("sorry empty array!");
    return null;
  }
  if(y.length === 0) {
    console.error("sorry array too short");
    return null;
  }
  if(y.length === 1) {
    return x;
  }
  return myButLast(list.slice(1));
};

// 3 find the kth element of a list. the first element is number 1
const elementAt = (list, k) => {
  const [x, y] = list;
  if (k === 1) {
    return x;
  }
  return elementAt(y, k-1);
};
