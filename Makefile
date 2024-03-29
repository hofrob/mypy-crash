rm_venv_caches:
	rm -r .uv-venv .mypy_cache/ || true

uv: rm_venv_caches
	uv venv .uv-venv
	uv pip compile pyproject.toml --output-file requirements.txt
	. ./.uv-venv/bin/activate && uv pip sync requirements.txt
	echo
	echo
	. ./.uv-venv/bin/activate && mypy --show-traceback mypy_crash/base.py

pip_full: rm_venv_caches
	rm -r .pip-venv || true
	chown root: /cache
	python -m venv .pip-venv
	uv pip compile pyproject.toml --output-file requirements.txt
	. ./.pip-venv/bin/activate && pip install -r requirements.txt
	echo
	echo
	. ./.pip-venv/bin/activate && mypy --show-traceback mypy_crash/base.py

pip: rm_venv_caches
	uv pip compile pyproject.toml --output-file requirements.txt
	. ./.pip-venv/bin/activate && pip-sync requirements.txt
	echo
	echo
	. ./.pip-venv/bin/activate && mypy --show-traceback mypy_crash/base.py
