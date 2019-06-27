# [ticket 787fa71](https://www.sqlite.org/src/tktview/787fa71)
- behavior: assertion failed
- description: the use of co-routine to implement a subquery and then evaluating that subquery for twice
- sketch:

    - `sqlite3VdbeExec` at sqlite.c:75522:

        ```C
        pC = p->apCsr[pOp->p1];
        assert( pC!=0 );
        ```

        Here `pC` is supposed to refer to a cursor which is a pointer into BTree used to seek to some entries. By looking into the code, we found that each time a query is processed, it is translated into bytecoded program, and an instance of bytecode virtual machine is created (`p`).

        As for the query that causes the assertion failure, I use `EXPLAIN` to see what instructions the bytecoded program consists of.(All instructions before assertion failure has been appended in explain.txt) The assertion failure happens when virtual machine executes `OP_Rewind`, `p1` of which is supposed to be the index of the cursor. Rewind means next use of that cursor would refer to the first entry. We can conclude from the instruction set (the output of `EXPLAIN`) that the query for `t2` is implemented by co-routine and after the first query is done, the cursor has to go back to the top before making second one. However, the cursor refered by `p1` is never opened(`OP_OpenRead` or `OP_OpenWrite`) before, *i.e.* `allocateCursor` is never called on that index of cursor. Therefore, the assertion failed. BTW, with assertion not triggered, segmentation fault will occur.

- patch:
    - [Disable co-routine in that case](https://www.sqlite.org/src/info/531eca6104e41e43)
    - [Evaluate Once instead of twice](https://www.sqlite.org/src/info/e130319317e76119)
    - [For non-constant expression, still twice](https://www.sqlite.org/src/info/778b1224a318d013)
