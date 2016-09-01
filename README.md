# BST Benchmarking in Elixir

tl;dr... I wonder if structs in Elixir are less efficient that tuples for implementing data structures.  Spoiler alert: they are by a factor of ~2.

## Motivation

I'm writing [`purely`](https://github.com/jdfrens/purely), an Elixir library for purely functional data structures (based on the book by the same name).  I started with the _binary search tree_ (BST).

I implemented BSTs using tuples as the underlying data structure thinking that they'd pretty efficient.

As I've worked on the library, I've wondered about using an Elixir [struct](http://elixir-lang.org/getting-started/structs.html) for the underlying data structure.  As a struct, I could implement [protocols](http://elixir-lang.org/getting-started/protocols.html) on my BST.  (A protocol can be defined on tuples, but it would apply to *all* tuples, not just my BST tuples.)  I really want to implement the `String.Chars` and `Enumerable` protocols, and I may want some protocols specific to this new library.

I can pattern match on both tuples and structs pretty easily.  Pattern matching on tuples can be very terse, but I have to remember the order of elements in the tuple.  Pattern matching on structs is a little more explicit which can help in readability; I can also ignore fields very easily.

The sticking point for me was the efficiency issue.  I figured structs would be less efficient because of the `Map` overhead.  This repo is an Elixir project to puts numbers to the efficiency.

## Implementation

I implemented `new` to create a new BST, `put` to put a key and value into a BST, and `inorder` to output a list of key-value tuples from the BST in order.

## Numbers

```
## InsertAndInorder   1_000 elements
benchm iterations   average time
tuple        2000   821.67 µs/op
map          1000   1623.12 µs/op

## InsertAndInorder  10_000 elements
benchm iterations   average time
tuple         100   11895.26 µs/op
map           100   19327.80 µs/op

## InsertAndInorder 100_000 elements
benchm iterations   average time
tuple          10   178781.70 µs/op
map             5   333043.60 µs/op
```

Struts are almost twice as slow.

## Conclusion

I may switch to structs anyway.  It's *only* twice as slow, and it will *not* grow larger as the size of the BST grows.  It's proportional to the number of keys in the struct, and that's constant.

## You can run this too!

1. Clone this project.
1. `mix deps.get`
1. `mix test`
1. `mix bench`
1. Tweak the code.
1. Rinse and repeat.
1. Profit.
