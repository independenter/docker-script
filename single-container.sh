#!/bin/sh


dir_str=$(dirname "$0");
basename_str=$(basename "$0");

print_usage()
{
progname="$basename_str";
echo "=======================================================================================";
echo "                         $progname HELP Screen                             ";
echo "=======================================================================================";
echo "Usage:	$progname [-H|h] -r -l {-c container_id|-n container_name}";
echo "			-h this screen";
echo "			-c container_id";
echo "			-n container_name";
echo "			-r restart";
echo "			-l log";
echo "			example";
echo "				$progname -r -c b2cf680a5f00";
echo "				$progname -l -c b2cf680a5f00";
echo "				$progname -r -n recruit_eureka";
echo "=======================================================================================";
}

restart()
{
	CONTAINER_ID_R=$1
	echo "${CONTAINER_ID_R} stoping ..."
	docker container stop ${CONTAINER_ID_R}
	echo "${CONTAINER_ID_R} stoped ..."
	echo "${CONTAINER_ID_R} starting ..."
	docker container start ${CONTAINER_ID_R}
	echo "${CONTAINER_ID_R} started ..."
	echo "${CONTAINER_ID_R} checking ..."
	docker ps -a|grep ${CONTAINER_ID_R}
	echo "${CONTAINER_ID_R} checked ..."
}

restart_name()
{
	#容器名
	CONTAINER_ID_R=$1
	echo "${CONTAINER_ID_R} stoping ..."
	docker container stop ${CONTAINER_ID_R}
	echo "${CONTAINER_ID_R} stoped ..."
	echo "${CONTAINER_ID_R} starting ..."
	docker container start ${CONTAINER_ID_R}
	echo "${CONTAINER_ID_R} started ..."
	echo "${CONTAINER_ID_R} checking ..."
	docker ps -a|grep ${CONTAINER_ID_R}
	echo "${CONTAINER_ID_R} checked ..."
}

attach()
{
	CONTAINER_ID_R=$1
	echo "${CONTAINER_ID_R} attaching ..."
	docker attach ${CONTAINER_ID_R}
	echo "${CONTAINER_ID_R} attaching ..."
}

log()
{
  CONTAINER_ID_R=$1
	echo "${CONTAINER_ID_R} loging ..."
	docker logs -f ${CONTAINER_ID_R}
}

if [ $# -eq 0 ] ; then 
	print_usage;
	exit;
fi

opt_str="C:c:N:n:rlHh";
CONTAINER_ID="";
CONTAINER_NAME="";
restart_flag=0;
log_flag=0;

while getopts $opt_str opt
do
	case $opt in
	C|c) CONTAINER_ID=$OPTARG;;
	N|n) CONTAINER_NAME=$OPTARG;;
	H|h) print_usage;exit;;
	r) restart_flag=1;;
	l) log_flag=1;;
	*) echo "error option";print_usage;exit;;
	esac
done


##[ $restart_flag -eq 1 ]
if [ -n "$CONTAINER_ID" ]&&[ $restart_flag -eq 1 ];then
	cond_str="CONTAINER_ID IN ($CONTAINER_ID)";
	echo "${cond_str}"
	restart $CONTAINER_ID
elif [ -n "$CONTAINER_ID" ]&&[ $log_flag -eq 1 ];then
	cond_str="CONTAINER_ID IN ($CONTAINER_ID)";
	echo "${cond_str}"
	log $CONTAINER_ID
elif [ -n "$CONTAINER_NAME" ]&&[ $restart_flag -eq 1 ];then
	cond_str="CONTAINER_NAME IN ($CONTAINER_NAME)";
	echo "${cond_str}"
	restart_name $CONTAINER_NAME
else
	print_usage;
	exit;
fi
