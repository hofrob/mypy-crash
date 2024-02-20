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
