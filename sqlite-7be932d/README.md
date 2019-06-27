# [ticket 7be932d](https://www.sqlite.org/src/tktview/7be932d)
- behavior: segmentation fault
- description: In CLI that uses SQLite, use a prepared statement for `.stats on` after it has been closed by the `.eqp full` logic.
- sketch:

    - `shell_exec` at shell.c:10289

        ```C
		if( pArg->autoEQP>=AUTOEQP_trigger && triggerEQP==0 ){
          sqlite3_db_config(db, SQLITE_DBCONFIG_TRIGGER_EQP, 0, 0);
          /* Reprepare pStmt before reactiving trace modes */
          sqlite3_finalize(pStmt);
          sqlite3_prepare_v2(db, zSql, -1, &pStmt, 0);
        }
		```

		In `sqlite3_finalize`, `pArg->pStmt->db` is set to null pointer, the memory pointed by which is later freed by sqlite.

	- `shell_exec` at shell.c:10316

		```C
		/* print usage stats if stats on */
		if( pArg && pArg->statsOn ){
		  display_stats(db, pArg, 0);
		}
		```
		
		- `display_stats` at shell.c:9788
		
			`iCur = sqlite3_stmt_status(pArg->pStmt, SQLITE_STMTSTATUS_MEMUSED, bReset);`

			- `sqlite3_stmt_status` at sqlite3.c:80357

                `sqlite3_mutex_enter(db->mutex);`

        in which a finalized prepared statement is used and segmentation happens when sqlite tried to acquir the lock first before using that statement.

- patch: [Avoid such case in description](https://www.sqlite.org/src/info/bb87c054b1b76959)
