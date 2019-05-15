# [ticket b899b60](https://www.sqlite.org/src/tktview/b899b60)
- behavior: segmentation fault
- description: correlated subquery on the RHS of an IN operator in the WHERE clause
- sketch:
  - sqlite3VdbeExec at sqlite3.c:81086

    `pC = p->apCsr[pOp->p1]`
    
    The cursor for the currrent operation cursor is null pointer and is assigned to `pC`

  - sqlite3VdbeExec at qlite3.c:81092
    
    `rc = sqlite3VdbeCursorMoveto(&pC, &p2)`

    - sqlite3VdbeCursorMoveto(pp, piCol) at sqlite3.c
    
      ```C
      VdbeCursor *p = *pp;
      if( p->eCurType==CURTYPE_BTREE ){
      ```

    opcode `OP_Column` is run on the cursor `pC`

- patch: [sqlite3SelectWalkFail](https://www.sqlite.org/src/info/c7f9f47b239fdd99)

