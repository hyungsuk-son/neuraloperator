# uv Development Guide

This repository uses `uv` as the standard Python package, environment, and
Python-version manager. The project targets Python 3.14 and uses Ruff for code
formatting and lint checks.

## Quick Start

On macOS or Linux, run:

```sh
scripts/bootstrap.sh
```

The bootstrap script checks whether `uv` is installed, installs it when needed,
installs Python 3.14 through uv, and syncs the project environment.

If you prefer to run the steps manually:

```sh
uv python install 3.14
uv sync --all-groups
uv run python --version
uv run ruff --version
```

## Installing uv

macOS and Linux:

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

After installation, open a new shell if `uv` is not immediately available on
your `PATH`.

## Python Version

The repository includes `.python-version` with:

```txt
3.14
```

uv reads this file when selecting or installing Python for the project. To
install the required Python manually:

```sh
uv python install 3.14
```

Useful Python commands:

```sh
uv python list
uv run python --version
uv run python
```

## Environment Sync

Install all locked project dependencies and development tools:

```sh
uv sync --all-groups
```

Run project commands inside the uv-managed environment:

```sh
uv run python
uv run python path/to/script.py
```

## Dependency Management

Add a runtime dependency:

```sh
uv add httpx
```

Add a development dependency:

```sh
uv add --dev pytest
```

Remove a dependency:

```sh
uv remove httpx
```

After dependency changes, commit both `pyproject.toml` and `uv.lock`.

## Formatting and Linting

Format Python files and notebooks:

```sh
uv run ruff format .
```

Check lint rules:

```sh
uv run ruff check .
```

Apply safe lint fixes:

```sh
uv run ruff check . --fix
```

Before submitting changes, run:

```sh
uv run ruff format .
uv run ruff check .
```

## Agent Workflow

AI coding agents should follow this sequence on a fresh checkout:

```sh
scripts/bootstrap.sh
uv sync --all-groups
uv run ruff format .
uv run ruff check .
```

When adding Python packages, update the project with `uv add` or
`uv add --dev`; do not edit virtualenv contents directly. Prefer `uv run` for
all Python and tool execution so commands use the same environment as humans.

## Troubleshooting

If `uv` was installed but the command is not found, restart the shell or add the
uv binary directory to `PATH`. On many Unix-like systems, this is:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

If Python 3.14 is not available, upgrade uv and retry:

```sh
uv self update
uv python install 3.14
```

If the environment looks stale after dependency changes:

```sh
uv sync --all-groups --reinstall
```
