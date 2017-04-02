class Tree {}
class TreeEmpty extends Tree{}
class TreeNode extends Tree {
  constructor(value) {
    super();
    this.value = value;
    this.left = new TreeEmpty;
    this.right = new TreeEmpty;
  }
}

const treeSize = (tree) => {
  // closest we can get to pattern matching syntax in javascript
  switch(tree.constructor) {
    case TreeEmpty:
      return 0;
    case TreeNode:
      return 1 + treeSize(tree.left) + treeSize(tree.right);
    default:
      return;
  }
};

const treeSum = (tree) => {
  switch(tree.constructor) {
    case TreeEmpty:
      return 0;
    case TreeNode:
      return tree.value + treeSize(tree.left) + treeSize(tree.right);
    default:
      return;
  }
};

const treeDepth = (tree) => {
  switch(tree.constructor) {
    case TreeEmpty:
      return 0;
    case TreeNode:
      return 1 + Math.max(treeSize(tree.left), treeSize(tree.right));
    default:
      return;
  }
};

const treeFlatten = (tree) => {
  switch(tree.constructor) {
    case TreeEmpty:
      return [];
    case TreeNode:
      return treeSize(tree.left).concat([tree.value]).concat(treeSize(tree.right));
    default:
      return;
  }
};

// lets write a treeFold function
const treeFold = (e, fn, tree) => {
  switch(tree.constructor) {
    case TreeEmpty:
      return e;
    case TreeNode:
      return fn(
        treeFold(e, fn, tree.left),
        tree.value,
        treeFold(e, fn, tree.right)
      );
    default:
      return;
  }
};

const treeSize = treeFold.bind(null, 0, (l, x, r) => 1 + l + r);
const treeSum = treeFold.bind(null, 0, (l, x, r) => x + l + r);
const treeDepth = treeFold.bind(null, 0, (l, x, r) => 1 + Math.max(l, r));
const treeFlatten = treeFold.bind(null, [], (l, x, r) => l.concat([x]).concat(r));
