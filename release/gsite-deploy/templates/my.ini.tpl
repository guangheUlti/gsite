# ===========================================================================
# MySQL 8 configuration of the GSite deploy package
# generated from templates\my.ini.tpl by gsite.ps1 - do not edit here,
# edit config.bat and re-run init.bat instead.
# comment character is '#' (REM is not accepted inside a cnf file)
# ===========================================================================
[mysqld]
port=@MYSQL_PORT@
bind-address=@MYSQL_BIND_ADDRESS@
basedir=@MYSQL_BASEDIR@
datadir=@MYSQL_DATADIR@
log-error=@MYSQL_LOGDIR@/mysqld.err

# ---- charset: utf8mb4 everywhere, this is what prevents the mojibake ----
# unicode_ci matches the COLLATE the seed scripts and CREATE DATABASE use, so objects
# created without an explicit collation (e.g. the Flowable act_* tables the BPM module
# auto-creates) inherit it too - a mix of collations breaks JOIN/UNION with error 1271.
character-set-server=utf8mb4
collation-server=utf8mb4_unicode_ci

# ---- general ----
default-storage-engine=INNODB
default-time-zone=+08:00
max_connections=@MYSQL_MAX_CONNECTIONS@
max_connect_errors=100000
max_allowed_packet=64M
table_open_cache=2000
thread_stack=512K
explicit_defaults_for_timestamp=ON
# the app runs a single MySQL instance, no replication / binlog needed
skip-log-bin

# ---- memory / performance ----
innodb_buffer_pool_size=@MYSQL_INNODB_BUFFER_POOL@
innodb_flush_log_at_trx_commit=1
innodb_io_capacity=200
performance_schema=OFF

# ---- slow query log (3s) ----
slow_query_log=ON
long_query_time=3
log_queries_not_using_indexes=OFF
slow_query_log_file=@MYSQL_LOGDIR@/slow.log

# ---- sql mode: same as the development environment ----
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION

[client]
port=@MYSQL_PORT@
default-character-set=utf8mb4

[mysql]
default-character-set=utf8mb4

[mysqldump]
default-character-set=utf8mb4
single-transaction=TRUE
