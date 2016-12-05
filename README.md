# Advent of code 2016 by @schovi

- from [Advent of code 2016](http://adventofcode.com/2016)
- using and learning [Crystal language](http://crystal-lang.org/)

## Run

`crystal run ./1/solution.cr`

## Notes for Crystal

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