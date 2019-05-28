# [ticket 7be932d](https://www.sqlite.org/src/tktview/7be932d]
- behavior: segmentation fault
- description: In CLI that uses SQLite, use a prepared statement for `.stats on` after it has been closed by the `.eqp full` logic.
- sketch:

- patch: [Avoid such case in description](https://www.sqlite.org/src/info/bb87c054b1b76959)
