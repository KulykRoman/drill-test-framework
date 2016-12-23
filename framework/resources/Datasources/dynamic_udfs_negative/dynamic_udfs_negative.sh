#!/bin/bash
source conf/drillTestConfig.properties

if rpm -qa | grep -q mapr-drill; then
  UDF_USER=mapr
else
  UDF_USER=root
fi

hadoop fs -test -d /user/$UDF_USER/drill/udf/staging
if [ $? != 0 ];
    then hadoop fs -mkdir /user/$UDF_USER/drill/udf/staging;
fi

hadoop fs -test -d /user/$UDF_USER/drill/udf/registry
if [ $? != 0 ];
    then hadoop fs -mkdir /user/$UDF_USER/drill/udf/registry
fi

hadoop fs -rm /user/$UDF_USER/drill/udf/staging/udf_with_packages-1.0*
hadoop fs -rm /user/$UDF_USER/drill/udf/staging/unregistration-1.0*
hadoop fs -put framework/resources/Datasources/dynamic_udfs_negative/jars/* /user/$UDF_USER/drill/udf/staging/

${DRILL_HOME}/bin/sqlline -u "jdbc:drill:zk=${ZOOKEEPER_HOST}:5181" -e "drop function using jar 'udf_with_packages-1.0.jar';"
${DRILL_HOME}/bin/sqlline -u "jdbc:drill:zk=${ZOOKEEPER_HOST}:5181" -e "drop function using jar 'unregistration-1.0.jar';"
