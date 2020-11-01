sleep 20
IFS=$'\n'
set -f

/opt/mssql-tools/bin/sqlcmd -H localhost -U 'sa' -P 'Sabbr@12345' -i sql-scripts/CreateDatabase.sql
