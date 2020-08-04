# mariadb-MDEV-21310
- behavior: Assertion failed

- description: Assertion `!is_set() || (m_status == DA_OK_BULK && is_bulk_op())` failed or late ER_PERIOD_FIELD_WRONG_ATTRIBUTES upon attempt to create existing table

- Affect version: 10.4,10.5