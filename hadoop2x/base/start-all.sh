#!/bin/bash

set -e

service sshd start

cd /opt/hadoop/hadoop-2.4.1

## start HDFS
sbin/hadoop-daemon.sh start namenode
sbin/hadoop-daemon.sh start datanode

## add user dirs
bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/root

## start yarn
sbin/yarn-daemon.sh start resourcemanager
sbin/yarn-daemon.sh start nodemanager

## upload data
./bin/hadoop fs -copyFromLocal logs/hadoop--namenode-$(hostname).log namenode.log

## run simple job
./bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.4.1.jar wordcount namenode.log /tmp/wordcount

./bin/yarn application -list -appStates ALL
