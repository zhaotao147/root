#!/bin/bash

#清空两个文件
>/tmp/host_up.txt
>/tmp/host_down.txt

#读取一个网络号
read -p "请指定一个网段（如1/1.1/1.1.1三种形式）： " net

#length=`echo “$net”|awk '{print length($0)}'`

#获取网络号的长度（1/1.1/1.1.1）
num=`echo "$net"|awk -F'.' '{print NF}'`

#根据输入网络号点号的数量判断网络号所属的类型
case $num in
1)
for((i=0;i<256;i++))
do
	for((j=0;j<256;j++))
	do
		for((k=0;k<256;k++))
		do
		{
		ping -c1 -W1 $net.$i.$j.$K &>/dev/null
		if [ $? -eq 0 ]
			then echo "$net.$i.$j.$K" >>/tmp/host_up.txt
			else echo "$net.$i.$j.$k" >>/tmp/host_down.txt	
		fi
		}&
		done
	done
done
;;
2)
for((a=0;a<256;a++))
do
	for((b=0;b<256;b++))
	do
		{
		ping -c1 -W1 $net.$a.$b &>/dev/null
		if [ $? -eq 0 ]
		then echo "$net.$a.$b" >>/tmp/host_up.txt
		else echo "$net.$a.$b" >>/tmp/host_down.txt
		fi
		}&
	done
done
;;
3)
for((x=0;x<256;x++))
do
	{
	ping -c1 -W1 $net.$x &>/dev/null
	if [ $? -eq 0 ]
	then echo "$net.$x" >>/tmp/host_up.txt
	else echo "$net.$x" >>/tmp/host_down.txt
	fi
	}&
done
;;

esac

wait
echo "finish"




