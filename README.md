# reproduce

```shell
docker build -t mypy-crash .
docker run \
    --rm \
    -it \
    --mount type=bind,source=./,target=/app/ \
    --mount type=bind,source=./cache/,target=/cache/ \
    mypy-crash \
    bash
```

Inside the container execute `make pip_full` to init the `pip-tools` venv.
Execute `make uv` shows a fatal error by mypy.
`make pip` does not show any error.

This is not reliably reproducible. I didn't find any causes.
Sometimes removing a completely unrelated library from `pyproject.toml` changes the outcome.

# actual crash output

```
. ./.uv-venv/bin/activate && mypy --show-traceback mypy_crash/base.py
mypy_crash/base.py:15: error: INTERNAL ERROR -- Please try using mypy master on GitHub:
https://mypy.readthedocs.io/en/stable/common_issues.html#using-a-development-mypy-build
Please report a bug at https://github.com/python/mypy/issues
version: 1.8.0
Traceback (most recent call last):
  File "mypy/semanal.py", line 6539, in accept
  File "mypy/nodes.py", line 1142, in accept
  File "mypy/semanal.py", line 1612, in visit_class_def
  File "mypy/semanal.py", line 1697, in analyze_class
  File "mypy/semanal.py", line 1731, in analyze_class_body_common
  File "mypy/semanal.py", line 1816, in apply_class_plugin_hooks
  File "/app/.uv-venv/lib/python3.12/site-packages/sqlalchemy/ext/mypy/plugin.py", line 267, in _base_cls_hook
    decl_class.scan_declarative_assignments_and_apply_types(ctx.cls, ctx.api)
  File "/app/.uv-venv/lib/python3.12/site-packages/sqlalchemy/ext/mypy/decl_class.py", line 102, in scan_declarative_assignments_and_apply_types
    _scan_declarative_assignment_stmt(
  File "/app/.uv-venv/lib/python3.12/site-packages/sqlalchemy/ext/mypy/decl_class.py", line 465, in _scan_declarative_assignment_stmt
    python_type_for_type = infer.infer_type_from_right_hand_nameexpr(
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.uv-venv/lib/python3.12/site-packages/sqlalchemy/ext/mypy/infer.py", line 57, in infer_type_from_right_hand_nameexpr
    python_type_for_type = _infer_type_from_decl_column(
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.uv-venv/lib/python3.12/site-packages/sqlalchemy/ext/mypy/infer.py", line 409, in _infer_type_from_decl_column
    python_type_for_type = extract_python_type_from_typeengine(
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/app/.uv-venv/lib/python3.12/site-packages/sqlalchemy/ext/mypy/infer.py", line 561, in extract_python_type_from_typeengine
    return get_proper_type(type_engine.args[-1])
                           ~~~~~~~~~~~~~~~~^^^^
IndexError: tuple index out of range
mypy_crash/base.py:15: : note: use --pdb to drop into pdb
```
