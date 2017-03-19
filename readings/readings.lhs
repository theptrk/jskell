source: http://www.imn.htwk-leipzig.de/~waldmann/etc/untutorial/list-or-not-list/
title: When You Should Use Lists in Haskell (Mostly, You Should Not)

Haskell is so in love with Lists they gave it Cons and (:) and []
Lists should only be used for iteration, not storage

Where do all the Lists come from?

Certainly Haskell builds on the legacy of LISP, the very first functional
programming language - that has lists in its name already. Indeed, singly
linked lists were the only way to structure nested data in LISP.

This is a huge advantage (it's soo uniform), but also a huge dis-advantage (you
cannot distinguish data - they all look like nested lists). For discriminating
between different shapes of nested data, people then invented algebraic data
types, pattern matching, and static typing. The flip side of static typing is
that it seems to hinder uniform data processing. So, language designers
invented polymorphism (type constructors) and generic programming, to get back
flexibility and uniformity, while keeping static safety.

The one major design goal for Haskell was: to define a functional programming
language with static typing and lazy evaluation.

source: https://medium.com/javascript-scene/functors-categories-61e031bac53f#.36vrqk12n
title: Functors and Categories

When you see functor you should think "mappable", as in it provides a mapping
interface

Arrays are the only Functors in Javascript

functor in haskell
> fmap :: (a -> b) -> f a -> f b
-- it takes a function that takes an `a` and returns a `b` and a functor of a

Functor laws
1. identity
  [1, 2, 3].map(x => x); // [1, 2, 3]

2. composition
  h.(g.f) = (h.g).f = h.g.f

  "javascript syntax example"
  funct.map(x => f(g(x))); is the same result as funct.map(g).map(f);

"A monad is just a monoid in the category of endofunctors. What’s the problem?"

A functor can map from category to category: F a -> F b.
An endofunctor can map from a category to the same category: F a -> F a.
