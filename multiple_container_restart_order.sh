#!/bin/bash

#author:donghui
INTERVAL_TIME=$1

restart(){
	order_info=`cat container_order.txt`
	while read line
	do
		echo "==================================================="
	  ./single-container.sh -r -n ${line}
	  sleep $1
	done <<< "$order_info";
}

if [ $INTERVAL_TIME -gt 5 ];then
   echo "容器启动间隔${INTERVAL_TIME}秒"
   restart $INTERVAL_TIME
else
   echo "容器启动间隔${INTERVAL_TIME}秒,间隔时间太短"
   exit
fi
