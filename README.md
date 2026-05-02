# NeuralOperator — Uraniborg AI

Neural operator research and data analysis workspace based on the
[NeuralOperator](https://github.com/NeuralOperator/neuraloperator) library
(Fourier Neural Operators and related architectures).

## Quick Start

Bootstrap the environment on a fresh machine:

```sh
scripts/bootstrap.sh
```

Then install the project with all dependencies:

```sh
uv sync --all-groups
uv pip install -e .
```

For manual setup and detailed uv usage, see [docs/uv.md](docs/uv.md).

## Running Code

All Python commands should go through `uv run`:

```sh
# Python REPL
uv run python

# Run a training script
uv run python scripts/train_darcy.py

# Run tests
uv run pytest neuralop/tests/
```

## Key Modules

| Path | Description |
|------|-------------|
| `neuralop/models/` | FNO, TFNO, GINO, and other operator architectures |
| `neuralop/data/` | Dataset loaders (Darcy flow, Navier-Stokes, etc.) |
| `neuralop/layers/` | Spectral convolution and attention layers |
| `neuralop/losses/` | H1 loss, LpLoss, and other operator losses |
| `neuralop/training/` | Trainer class and callbacks |
| `scripts/` | Training entry points per benchmark |
| `config/` | YAML configuration files |
| `examples/` | Jupyter notebook tutorials |

## Quick Model Example

```python
from neuralop.models import FNO

model = FNO(n_modes=(64, 64), hidden_channels=64, in_channels=2, out_channels=1)
```

## Standard Commands

```sh
uv run ruff format .
uv run ruff check .
uv run pytest neuralop/tests/
```

## Adding Dependencies

```sh
uv add <package>        # runtime
uv add --dev <package>  # dev/analysis tools
```

Upstream docs: [neuraloperator.github.io](https://neuraloperator.github.io/dev/index.html)
