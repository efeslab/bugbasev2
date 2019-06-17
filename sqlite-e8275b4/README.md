# [ticket e8275b4](https://www.sqlite.org/src/tktview/e8275b4)
- behavior: assertion failed(unexpected null pointer)
- description: use of window functions with recursive CTE
- sketch:
- patch: [Disallow the use of window functions in the recursive part of a recursive CTE](https://www.sqlite.org/src/info/b2849570967555d4)
