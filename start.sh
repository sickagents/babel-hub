#!/bin/bash
# BabelHub launcher — edit the wallet address below before running.
#
# This wallet receives the operator fee (1.0% base + 0.5% tx-fee reserve
# = 1.5% total) from every batch processed by the pool.  See
# docs/FEE-STRUCTURE.md for the breakdown.

set -euo pipefail

# Default wallet (override via pool.env or --wallet flag)
DEFAULT_WALLET="prl1pYOUR_OPERATOR_WALLET"

# Source pool.env if exists
if [ -f ./pool.env ]; then
  set -a
  source ./pool.env
  set +a
fi

# Use BABELHUB_WALLET from pool.env, fallback to default
WALLET="${BABELHUB_WALLET:-$DEFAULT_WALLET}"

if [ "$WALLET" = "prl1pYOUR_OPERATOR_WALLET" ]; then
  echo "ERROR: Wallet not set."
  echo "Edit pool.env and set BABELHUB_WALLET=prl1pYOUR_ADDRESS"
  exit 1
fi

exec node src/pool.js --wallet "$WALLET" "$@"
