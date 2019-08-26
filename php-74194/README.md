# [bug 74194](https://bugs.php.net/bug.php?id=74194)
- behavior: segmentation fault
- description: the property of array object reference to itself
- sketch: 

    - `spl_array_object_new` at ext/spl/spl_array.c:272

        `return spl_array_object_new_ex(class_type, NULL, 0);`

        - `spl_array_object_new_ex(zend_class_entry * class_type, zval *orig, int clone_orig)` at ext/spl/spl_array.c:205

        ```C
        spl_array_object *intern;
        zend_class_entry *parent = class_type;
        int inherited = 0;

        intern = ecalloc(1, sizeof(spl_array_object) + zend_object_properties_size(parent));

        zend_object_std_init(&intern->std, class_type);
        object_properties_init(&intern->std, class_type);

        ~~~~~~~~~~~~~~~~~~
        if (orig) {
            ~~~~~~~~~
        } else {
            array_init(&intern->array);
        }
        ```

        An `spl_array_object` is initialized for "ArrayObject", one thing worth notifying are that
        
        - `intern->array.u1.v.type` is set to `IS_ARRAY`

    - `zim_spl_Array_unserialize` at ext/spl/spl_array.c:1798

        `spl_array_object *intern = Z_SPLARRAY_P(getThis());`

        Find initialized actual array object, which later shoud be used to store actual data converted from serialized data.

        ```C
        zval_ptr_dtor(&intern->array);
        ZVAL_UNDEF(&intern->array);
        if (!php_var_unserialize(&intern->array, &p, s + buf_len, &var_hash)
        ```

        Set `intern->array.u1.v.type` to `IS_UNDEF`.
        `php_var_unserialize` initializes memory pointed by `intern->array.value.obj` with proper value.

    - `php_var_unserialize_internal` at ext/standard/var_unserializer.c:1011

        `ZVAL_NEW_REF(rval_ref, rval_ref);`

        Here, `rval_ref` is exactly `spl_array_object`, *i.e.* `intern` mentioned before, though appears to be `struct _zval_struct *`. When unserializing "R:5" in `data`, *i.e.* reference to "ArrayObject", the previously mentioned `intern->array.value.obj` is pointed to a different memory. However, the value in new memory doesn't make sence.

    - `zim_spl_Array_serialize` at ext/spl/spl_array.c:1691

        ```C
        zval *object = getThis();
        spl_array_object *intern = Z_SPLARRAY_P(object);
        HashTable *aht = spl_array_get_hash_table(intern);
        ```

        When the previously unserialized "ArrayObject" is goind to be serialized again, find its properties(hash table) first.

        - `spl_array_get_hash_table` at ext/spl/spl_array.c:113

            `return *spl_array_get_hash_table_ptr(intern);`

            - `spl_array_get_hash_table_ptr` at ext/spl/spl_array.c:100

                ```C
                } else if (Z_TYPE(intern->array) == IS_ARRAY) {
                    return &Z_ARRVAL(intern->array);
                } else {
                    zend_object *obj = Z_OBJ(intern->array);
                    if (!obj->properties) {
                        rebuild_object_properties(obj);
                    }
                ```

                Since the type of `intern` was incorrectly set to `IS_UNDEF` from `IS_ARRAY` (destrutor was also called on `intern->array`, we have to rebuild object properties, *i.e.* HashTable, from `Z_OBJ(intern->array) = intern->array.value.obj`.


                - `rebuild_object_properties` at Zend/zend_object_handlers.c:80

                    ```C
                    zend_property_info *prop_info;
                    zend_class_entry *ce = zboj->ce;

                    ALLOC_HASHTABLE(zobj->properties);
                    zend_hash_init(zobj->properties, ce->default_properties_count, NULL, ZVAL_PTR_DTOR, 0);
                    ```

                    Attempt to deferencing `intern->array.value.obj->ce` failed and resulted in segmentation fault.

- patch: [instead of only calling destructor, reconstruct array object](http://git.php.net/?p=php-src.git;a=commit;h=afc22828ea036814e6a044083dade065b4c858c9)
