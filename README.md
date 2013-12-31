Backup_sort
===========

Sorting backups on the web server. Keep for month, week and day backups

RUS:
Скрипт полезно применять на серверах, управляемых directadmin, cpanel, 
для ежедневных копий, вместо традиционно настраиваемых еженедельных и 
ежемесячных бекапов, которые могут стартовать одновременно с ежедневными 
и вызывать дополнительную нагрузку на сервер. 
На сервере можно оставить только ежедневное резервирование. Скрипт запускается 
(планируется в cron) за некоторое время (10 минут на перенос файлов в рамках
одного раздела может быть достаточно) до запланированной зачачи резервирования 
и переносит резервные копии последнего ежедневного бекапа в зависимости от 
настроек и дня месяца в папки для ежемесячного, еженедельного или бекапа 
прошлого дня.
Всего может быть шесть резервных копий: текущяя, за прощлый день, недельная, 
за прошлую неделю, месячная и за прошлый месяц

ENG:
The script is useful for servers that are managed directadmin, cpanel,
for daily backups, instead of the traditional weekly and monthly backups, 
which may start at the same time daily and cause extra load on the server.
On the server, you can leave only daily backups. Script runs (scheduled in cron) 
for some time before (10 minutes for transfer files within
one section may be sufficient) the scheduled backup tasks from
and transfers the backups last daily backup, depending on the
settings and day of the month in the folder for a monthly, weekly or backup
the last day.
There can be six backups: are current, for proschly day, week,
over the past week, month and for the last month.
