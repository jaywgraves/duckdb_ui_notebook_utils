#!/bin/bash
SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR" || { echo "Error: Could not change to script directory."; exit 1; }

# check to see if duckdb ui session is already running and exit
# a running session will hold a lock on the `ui.db` file and the sql export command below will fail
# leaving behind an empty `duckdb_notebooks.json` file which will cause `duckdb_notebooks_search.sh` to fail
lsof_output=$(lsof -t "/Users/g274496/.duckdb/extension_data/ui/ui.db" 2>/dev/null)

if [ -n "$lsof_output" ]; then
    echo "Error: duckdb -ui session is already running.  stop that process to release the lock on the notebook database"
    exit 1
fi

duckdb -readonly -json -s "select notebook_id,title,created,json_extract(json_extract(json::JSON,'cells'),'$') as jsoncells from notebook_versions where expires is null;" ~/.duckdb/extension_data/ui/ui.db > duckdb_notebooks.json

# version -u $(openssl md5 duckdb_notebooks.json | awk '{print $2}') duckdb_notebooks.json
# mv duckdb_notebooks.*.json archive

version duckdb_notebooks.json
mkdir -p archive
mv duckdb_notebooks.*.*.json archive