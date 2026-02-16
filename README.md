utilities for dumping and search the notebooks from the internal duckdb ui database


currently only tested on MacOS but could easily be tweaked for Linux
(and I'll be working on that)


I like to make aliases to make this easier to use.

```shell
alias duckdb_notebooks_export=~/duckdb_notebooks/duckdb_notebooks_export.sh
alias duckdb_notebooks_search=~/duckdb_notebooks/duckdb_notebooks_search.sh
```

requirements
----
- duckdb
- jq
- [version](https://github.com/jaywgraves/version)  this just makes a backup each time you export the notebooks.  It can easily be commented out.
