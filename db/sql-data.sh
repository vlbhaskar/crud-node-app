echo "started executing the data scripts"
/opt/mssql/bin/sqlservr &
while ! /opt/mssql-tools/bin/sqlcmd -H localhost -U 'sa' -P 'FOURsaken1'; do
  sleep 1
done
for i in $(cat < "sql-scripts/ImsManifest-Data.txt"); do
  echo $i
  /opt/mssql-tools/bin/sqlcmd -H localhost -d 'PTO_Tenant' -U 'sa' -P 'FOURsaken1' -i sql-scripts/$i
done
echo "finished executing the data scripts"
wait -n
