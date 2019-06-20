# [ticket 787fa71](https://www.sqlite.org/src/tktview/787fa71)
- behavior: assertion failed
- description: In CLI that uses SQLite, use a prepared statement for `.stats on` after it has been closed by the `.eqp full` logic.
- sketch:

- patch: [](https://www.sqlite.org/src/info/778b1224a318d013)
