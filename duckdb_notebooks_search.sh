#!/bin/bash
SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR" || { echo "Error: Could not change to script directory."; exit 1; }

duckdb -json -s "with first as (select title, created, unnest(jsoncells) as cells from read_json_auto('duckdb_notebooks.json')) select title, created, cells.cellid as cellid, cells.query as sql from first where cells.query ilike '%$1%' order by created desc;"  | jq -r -c '.[] | (" - - - - - - - - - -",.title,.created,.cellid, " - - - - - - - - - -", .sql)' | less -i -p "$1"
