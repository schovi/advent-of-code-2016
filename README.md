# Advent of code 2016 by @schovi

- from [Advent of code 2016](http://adventofcode.com/2016)
- using and learning [Crystal language](http://crystal-lang.org/)

## Run

`crystal run ./1/solution.cr`

## Notes for Crystal


### Day 1
- There is no `.to_sym` on String, because symbols are converted into numbers during compile time.

- cant use return keyword in toplevel 
```
some_array.map do |value|
  return 1
end

=>
in 1/some.cr:2: can't return from top level
```

- destructuring tuple in block is like ... do |(x,y)| ... end
  - but on toplevel `x,y = tuple` (which makes sense :)


### Day 2

- Watch your **chars** - Always confuse me if I have char or string!

### Day 3

Watch your maybe values in arrays

```
array = [1, 2, 3, 4]
typeof(array.in_groups_of(2))    # => Array(Array(Int32 | Nul))
typeof(array.in_groups_of(2, 0)) # => Array(Array(Int32)) 
```