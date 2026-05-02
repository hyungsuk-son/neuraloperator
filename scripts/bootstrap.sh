#!/usr/bin/env sh
set -eu

UV_BIN="${UV_BIN:-uv}"

if ! command -v "$UV_BIN" >/dev/null 2>&1; then
    echo "uv is not installed. Installing uv with the official installer..."
    if command -v curl >/dev/null 2>&1; then
        curl -LsSf https://astral.sh/uv/install.sh | sh
    elif command -v wget >/dev/null 2>&1; then
        wget -qO- https://astral.sh/uv/install.sh | sh
    else
        echo "Neither curl nor wget is available. Install uv manually: https://docs.astral.sh/uv/"
        exit 1
    fi

    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
fi

if ! command -v "$UV_BIN" >/dev/null 2>&1; then
    echo "uv was installed, but it is not available on PATH."
    echo "Open a new shell or add uv's install directory to PATH, then rerun this script."
    exit 1
fi

"$UV_BIN" python install 3.14
"$UV_BIN" sync --all-groups

"$UV_BIN" run python --version
"$UV_BIN" run ruff --version
