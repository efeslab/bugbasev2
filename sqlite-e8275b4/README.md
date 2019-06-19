# [ticket e8275b4](https://www.sqlite.org/src/tktview/e8275b4)
- behavior: assertion failed(unexpected null pointer)
- description: use of window functions with recursive CTE
- sketch:
     - `generateWithRecursiveQuery` at sqlite3.c:125459

        ```C
        for(i=0; ALWAYS(i<pSrc->nSrc); i++){
            if( pSrc->a[i].fg.isRecursive ){
                iCurrent = pSrc->a[i].iCursor;
                break;
            }
        }
        ```

        This code snnipet is supposed to find the cursor numnber of the current table, which is used in the FROM clause of the recursive query. (There should be one and only one such table) However, ALWAYS assertion failed because no such table is found. A simplified query(test1.sqlite) different from the original one reported in the ticket is used to understand what has happened. `count(*)` is a window function that require information from all rows of target table while the result of select statement within recursive-table is allowed to be only dependent on the top row of queue table, otherwise table i would be dependent on its own（kind of circular defintion).

- patch: [Disallow the use of window functions in the recursive part of a recursive CTE](https://www.sqlite.org/src/info/b2849570967555d4)
