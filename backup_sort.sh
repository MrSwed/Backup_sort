#!/bin/bash
. $HOME/.bash_profile
# Sorting hosting account backups
# Sergey Davydov <admin@collection.com.ua>

# defaults

root_dir=~/user_backups
mask=*.tar.gz
def_sour=$root_dir
dest_by_weekday[6]=$root_dir/weekly
dest_by_monday[1]=$root_dir/monthly

#defaults previou versions, comment var if din't need it
#dest_prev_week=$root_dir/weekly2
#dest_prev_mon=$root_dir/monthly2
dest_prev_day=$root_dir/daily2

# date format for output
date_format=\""+%F %T"\"

if [ ! -n "$1" ]
then
  echo
  echo "Tool for sorting backup files by day of mounth or week."
  echo "Steps: "
  echo " First: move previous backup to specified folder depend on week day, mounth day or simple - current daily,"
  echo " Second: move daily to folder depend on day"
  echo 
  echo "Put it to cron sheduled with start time before creating daily backups. "
  echo "Set time start by depend on backups count and time needed to move its with rewrite"
  echo 
  echo "Usage: `basename $0` [start] [-s <source_dir>] [-d <destination_dir>]"
  echo
  echo "For start sorting automaticaly, set only \"start\" param.  "
  echo "For manualy start moove: set -d  and -s if needed"
  echo "Default source - $def_sour, destination - by week, mounth day."
  echo
  echo
  exit 0
fi

# get parameters
until [ -z "$1" ]; do
  case "$1" in
    -q ) quiet=$1;;
    -s ) sour=$2; shift;;
    -d ) dest=$2; shift;;
    start ) start=$1;;
  esac
  shift
done 

[ $sour ] || sour=$def_sour

if [[ -n $dest && -n $sour ]]
then
 if [ ! -d $sour ]
 then
  echo "Source dir \"$sour\" not exist"
 else
  [ -d $dest ] || echo "`eval date $date_format`: `mkdir -vp $dest 2>&1`" || exit 1
  if [[ "$dest" == "$sour" ]]
  then
   echo "`eval date $date_format`: $dest == $sour. Nothing move."
  else
   echo "`eval date $date_format`: start moving from $sour/$mask to $dest"
   for file in $sour/$mask
   do
    echo "`eval date $date_format`: `mv -fv -t $dest $file 2>&1`"
#    echo "`eval date $date_format`: mv -fv -t $dest $file"
   done
   echo "`eval date $date_format`: end moving from $sour/$mask to $dest"
   echo
  fi
 fi
 exit 0
fi

if [[ $start ]] # auto
then
 if [ `ls -1 $sour | grep -c ""` -eq 0 ]
 then
  echo "`eval date $date_format`: $sour is empty"
  exit 0
 fi
 thisday=$((10#`date +%d` * 1))                                             # Monthly backup
# if [[ ${dest_by_monday[`date +%d`]} ]]                                 # Monthly backup
 if [[ ${dest_by_monday[thisday]} ]]
 then
  [ $dest_prev_mon ] && $0 $quiet -s ${dest_by_monday[thisday]} -d $dest_prev_mon
  $0 $quiet -s $sour -d ${dest_by_monday[thisday]}
 elif [[ ${dest_by_weekday[`date +%u`]} ]]                                  # Weekle backup
 then
  [ $dest_prev_week ] &&  $0 $quiet -s ${dest_by_weekday[`date +%u`]} -d $dest_prev_week
   $0 $quiet -s $sour -d ${dest_by_weekday[`date +%u`]}
 else                                                                     # Only previously daily 
  [ $dest_prev_day ] && $0 $quiet -s $sour -d $dest_prev_day
  
 fi
fi


