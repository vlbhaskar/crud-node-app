FROM mcr.microsoft.com/mssql/server:2017-latest
ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=Sabbr@12345
ENV MSSQL_PID=Developer
EXPOSE 1433
COPY ./ .
RUN chmod +x ./execute-sql.sh
RUN chmod +x ./run-scripts.sh
CMD /bin/bash ./run-scripts.sh

