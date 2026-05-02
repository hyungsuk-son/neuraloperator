# AGENTS.md

This repository is a uv-based Python project template for Uraniborg AI work.
Use [docs/uv.md](docs/uv.md) as the source of truth for environment setup,
dependency management, and formatting commands.

## Development Rules

- Use Python 3.14.
- Use `uv` for Python installation, dependency management, virtualenv creation,
  and command execution.
- Bootstrap a fresh machine with `scripts/bootstrap.sh` on macOS or Linux.
- Run Python commands through `uv run`, for example `uv run python`.
- Add runtime dependencies with `uv add <package>`.
- Add development dependencies with `uv add --dev <package>`.
- Do not use `pip install` for project dependencies unless the uv documentation
  explicitly requires the `uv pip` compatibility interface for a one-off task.
- Format code with `uv run ruff format .`.
- Check lint rules with `uv run ruff check .`.
- Keep generated virtual environments, caches, and local artifacts out of git.

## Standard Commands

```sh
scripts/bootstrap.sh
uv sync --all-groups
uv run python --version
uv run ruff format .
uv run ruff check .
```
