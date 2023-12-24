FROM postgres:15.3-alpine3.18

MAINTAINER Toae inc
LABEL toae.role=system

ENV TOAE_POSTGRES_USER_DB_HOST=toae-postgres \
    TOAE_POSTGRES_USER_DB_PORT=5432 \
    TOAE_POSTGRES_USER_DB_USER=toae \
    TOAE_POSTGRES_USER_DB_PASSWORD=toae \
    TOAE_POSTGRES_USER_DB_NAME=users \
    TOAE_POSTGRES_USER_DB_SSLMODE=disable \
    DF_PROG_NAME="postgres1" \
    PGDATA="/data/postgres1/data"
#ENV PGDATA /var/lib/postgresql/data
#ENV POSTGRES_INITDB_XLOGDIR /var/log/postgresql/logs

COPY create-pg-dirs.sh /usr/local/bin/
COPY create-pg-db.sh /docker-entrypoint-initdb.d/
RUN cp /usr/local/bin/docker-entrypoint.sh /usr/local/bin/new-docker-entrypoint.sh
COPY postgres-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 755 /usr/local/bin/create-pg-dirs.sh /docker-entrypoint-initdb.d/create-pg-db.sh /usr/local/bin/docker-entrypoint.sh
#The script create-pd-dirs.sh will copy postgresql.conf file into PGDATA
#COPY postgresql.conf /usr/local/
