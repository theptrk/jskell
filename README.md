# Explorations into JS and Haskell

## Installing Haskell

### Use Stack to get GHC installed

__How?__

As a new user you *will* run into package version conflicts that are way beyond your reasoning

> "I used to tell people in my guide to install Haskell Platform, but I
> stopped because it kept creating problems. Haskell Platform causes trouble
> for new people when the globally installed packages get old. These very
> same new people are the ones least equipped to cope with or understand the
> problem or where it comes from."
> `-` Christopher Allen

Install [Stack](http://haskellstack.org)
Quickstart Unix: `curl -sSL https://get.haskellstack.org/ | sh`
You may need: `stack setup`

## Why Haskell?

Haskell is functional, pure, lazy and strongly typed. JavaScript libraries and
compilers work towards these ends since authors have found the incredible
benefits when working within these paradigms. Haskell is worth the exploration
to find out what trade offs and incredible benefits are being gained here.
- Ramda.js and lodash-fp emphasizes functional style with automatically curried
  functions
- TypeScript and Flow are introducing static type checking to a new generation
  of dynamically scripting JavaScript engineers

