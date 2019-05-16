# [ticket d8dc2b3](https://www.sqlite.org/src/tktview/d8dc2b3)
- behavior: segmentation fault
- description: When the entry in the sqlite_master table that describes the sqlite_sequence is corrupted in various ways, subsequent writes to an autoincrement table result in a segmentation fault.
- sketch:
  - sqlite3SchemaClear at sqlite3.c:108099
    
    `pSchema->pSeqTab = 0;`

    When opening a corrupted sqlite_sequence table(indicating it is no longer based on sqlite_sequence, `pSchema->pSeqTab` is set to nullptr as expected.

  - sqlite3OpenTable at sqlite3.c:112450

    `sqlite3TableLock(pParse, iDb, pTab->tnum, (opcode==OP_OpenWrite)?1:0, pTab->zName);`

    Here, the value of `pTab` evaluates to `pParse->db->aDb[pParse->pAinc->iDb]->pSchema->pSeqTab`, in which `pParse->db->aDb[pParse->pAince->iDb]` refers to the corrupted table. Accession the member of a `Table` struct referenced by a null pointer resulting in sementaion fault.

- patch: [Verify that the sqlite_sequence table exists and is in approximately the correct format prior to using it to process an autoincrement table](https://www.sqlite.org/src/info/e199e859ace4f838)

