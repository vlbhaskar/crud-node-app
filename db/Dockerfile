FROM mcr.microsoft.com/mssql/server:2017-latest
# RUN apt-get update && apt-get install dos2unix && apt-get install unzip -y && apt-get install -y apt-utils
# RUN wget -progress=bar:force -q -O sqlpackage.zip https://go.microsoft.com/fwlink/?linkid=873926 \
#     && unzip -qq sqlpackage.zip -d /opt/sqlpackage \
#     && chmod +x /opt/sqlpackage/sqlpackage
ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=Sabbr@12345
ENV MSSQL_PID=Developer
EXPOSE 1433
COPY ./ .

RUN chmod +x ./execute-sql.sh
RUN chmod +x ./run-scripts.sh
# RUN chmod +x ./sql-data.sh
CMD /bin/bash ./run-scripts.sh
# RUN ( /opt/mssql/bin/sqlservr & ) | grep -q "Service Broker manager has started" \
#     && /opt/sqlpackage/sqlpackage /a:Publish /tsn:. /tdn:PTO_Tenant /tu:sa /tp:FOURsaken1 /sf:/tmp/db.dacpac /v:FirmId=40 /v:FirmName=bdd \
#     && rm /tmp/db.dacpac \
#     && pkill sqlservr

# CMD /bin/bash ./sql-data.sh
