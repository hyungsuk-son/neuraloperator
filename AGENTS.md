# AGENTS.md

This repository is a neural operator research and data analysis workspace for
Uraniborg AI, built on the NeuralOperator library.
Use [docs/uv.md](docs/uv.md) as the source of truth for environment setup,
dependency management, and formatting commands.

## Development Rules

- Use Python 3.14.
- Use `uv` for Python installation, dependency management, virtualenv creation,
  and command execution.
- Bootstrap a fresh machine with `scripts/bootstrap.sh` on macOS or Linux.
- Run Python commands through `uv run`, for example `uv run python`.
- Install the neuraloperator package in editable mode: `uv pip install -e .`
- Add runtime dependencies with `uv add <package>`.
- Add development dependencies with `uv add --dev <package>`.
- Do not use `pip install` for project dependencies unless the uv documentation
  explicitly requires the `uv pip` compatibility interface for a one-off task.
- Format code with `uv run ruff format .`.
- Check lint rules with `uv run ruff check .`.
- Keep generated virtual environments, caches, and local artifacts out of git.

## Project Structure

- `neuralop/models/` — FNO, TFNO, GINO, and other neural operator architectures
- `neuralop/data/` — Dataset loaders (Darcy flow, Navier-Stokes, etc.)
- `neuralop/layers/` — Spectral convolution and attention layers
- `neuralop/losses/` — Operator-specific loss functions
- `neuralop/training/` — Trainer class and training callbacks
- `scripts/` — Training entry points per benchmark problem
- `config/` — YAML configuration files for experiments
- `examples/` — Jupyter notebook tutorials

## Git Remotes

이 프로젝트는 두 개의 리모트에 동시에 푸시하도록 설정되어 있습니다.

- `myfork` — `git@github.com:hyungsuk-son/neuraloperator.git` (개인 포크)
- `uraniborg` — `git@github.com:uraniborg-ai/neuraloperator.git` (팀 리파지토리)

`myfork`에 두 URL이 모두 push URL로 등록되어 있으므로, `git push`만 실행하면
두 리파지토리에 동시에 반영됩니다.

새 머신에서 이 설정을 복원하려면 아래 명령을 실행하세요.

```sh
git remote set-url --add --push myfork git@github.com:hyungsuk-son/neuraloperator.git
git remote set-url --add --push myfork git@github.com:uraniborg-ai/neuraloperator.git
```

## Standard Commands

```sh
scripts/bootstrap.sh
uv sync --all-groups
uv pip install -e .
uv run python --version
uv run pytest neuralop/tests/
uv run ruff format .
uv run ruff check .
```
