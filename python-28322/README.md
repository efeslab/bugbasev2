# [python-28322](https://bugs.python.org/issue28322)
- behavior: segmentation fault(try to call a function pointed by a null pointer)
- description: `itertools.chain().__setstate__` use non-iterator object, which should be a typeError reported python. Later, using `__next__` on that `chain` object leak systemError.
- sketch:

    - `chain_setstate(chainobject *lz, PyObject *state)` at ./Modules/itertoolsmodule.c:1898

        ```C
        if (! PyArg_ParseTuple(state, "O|O", &source, &active))
            return NULL;

        Py_INCREF(source);
        Py_XSETREF(lz->source, source);
        ```

        This code is executed when Python run `var_dxtwgisr.__setstate__((1,))`. It only checks the validity of the argument of `__setstate__', but neglect the type checking. Here, `source` is a `PyObject` representing `1`. `source->ob_type` is `PyLong_Type`, which is obviously not a iterator. Therefore, `source->obtype->PyIter_Next` is null.

        Besides, `Py_XSETREF` set `lz->source` to `source` and maintain the refcount, *ie*, bound `source` to the chain object.

    - `chain_next(chainobject *lz)` at ./Modules/itertoolsmodule.c:1898

        ```C
        PyObject *iterable = PyIter_Next(lz->source);
        ```

        - `PyIter_Next(PyObject *iter)` at Objects/abstract.c:2778

            ```C
            result = (*iter->ob_type->tp_iternext)(iter);
            ```

        Later, when Python execute `var_dxtwgisr.__next__()`, `chain_next` is called upon the chain object, which invokes `PyIter_Next` to return next item. However, as we have shown, the source of the chain object is not a iterable object. The method used to find next object `iter->ob_type->tp_iternext` is null, thus undefined for `PyLong_Type`.

- patch: [Add type checking](https://hg.python.org/cpython/rev/258ebc539b2e)
