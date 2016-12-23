#!/bin/bash

IFS=',' read -ra ADDR <<< "$DRILLBITS"

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

hadoop fs -rm /user/$UDF_USER/drill/udf/staging/without_conf_udf-1.0*
hadoop fs -rm /user/$UDF_USER/drill/udf/staging/exists_udf-1.0*
hadoop fs -rm /user/$UDF_USER/drill/udf/staging/native_udf_check-1.0*
hadoop fs -rm /user/$UDF_USER/drill/udf/staging/udf_sanity_check-1.0*
hadoop fs -rm /user/$UDF_USER/drill/udf/staging/udf_for_drill_0.9-1.0*
hadoop fs -rm /user/$UDF_USER/drill/udf/staging/inner_udf-1.0*
hadoop fs -rm /user/$UDF_USER/drill/udf/staging/subquery_udf-1.0*
hadoop fs -rm /user/$UDF_USER/drill/udf/staging/jar_without_udf-1.0*
hadoop fs -rm /user/$UDF_USER/drill/udf/staging/udf_with_packages-1.0*
hadoop fs -rm /user/$UDF_USER/drill/udf/staging/register_from_one-1.0*
hadoop fs -rm /user/$UDF_USER/drill/udf/staging/update_function-1.0*
hadoop fs -put framework/resources/Datasources/dynamic_udfs/jars/* /user/$UDF_USER/drill/udf/staging/
hadoop fs -put framework/resources/Datasources/dynamic_udfs/jars_local/update_function/before_update/* /user/$UDF_USER/drill/udf/staging/

${DRILL_HOME}/bin/sqlline -u "jdbc:drill:zk=${ZOOKEEPER_HOST}:5181" -e "drop function using jar 'exists_udf-1.0.jar';"
${DRILL_HOME}/bin/sqlline -u "jdbc:drill:zk=${ZOOKEEPER_HOST}:5181" -e "drop function using jar 'native_udf_check-1.0.jar';"
${DRILL_HOME}/bin/sqlline -u "jdbc:drill:zk=${ZOOKEEPER_HOST}:5181" -e "drop function using jar 'udf_sanity_check-1.0.jar';"
${DRILL_HOME}/bin/sqlline -u "jdbc:drill:zk=${ZOOKEEPER_HOST}:5181" -e "drop function using jar 'udf_for_drill_0.9-1.0.jar';"
${DRILL_HOME}/bin/sqlline -u "jdbc:drill:zk=${ZOOKEEPER_HOST}:5181" -e "drop function using jar 'inner_udf-1.0.jar';"
${DRILL_HOME}/bin/sqlline -u "jdbc:drill:zk=${ZOOKEEPER_HOST}:5181" -e "drop function using jar 'subquery_udf-1.0.jar';"
${DRILL_HOME}/bin/sqlline -u "jdbc:drill:zk=${ZOOKEEPER_HOST}:5181" -e "drop function using jar 'jar_without_udf-1.0.jar';"
${DRILL_HOME}/bin/sqlline -u "jdbc:drill:zk=${ZOOKEEPER_HOST}:5181" -e "drop function using jar 'udf_with_packages-1.0.jar';"

${DRILL_HOME}/bin/sqlline -u "jdbc:drill:drillbit=${ADDR[0]}:31010" -e "drop function using jar 'register_from_one-1.0.jar';"
hadoop fs -rm -r /user/$UDF_USER/drill/udf/registry
${DRILL_HOME}/bin/sqlline -u "jdbc:drill:drillbit=${ADDR[0]}:31010" -e "create function using jar 'register_from_one-1.0.jar';"

${DRILL_HOME}/bin/sqlline -u "jdbc:drill:drillbit=${ADDR[0]}:31010" -e "drop function using jar 'update_function-1.0.jar';"
${DRILL_HOME}/bin/sqlline -u "jdbc:drill:drillbit=${ADDR[0]}:31010" -e "create function using jar 'update_function-1.0.jar';"

${DRILL_HOME}/bin/sqlline -u "jdbc:drill:drillbit=${ADDR[0]}:31010" -e "create function using jar 'exists_udf-1.0.jar';"
hadoop fs -put framework/resources/Datasources/dynamic_udfs/jars/exists_udf-1.0* /user/$UDF_USER/drill/udf/staging/

hadoop fs -put framework/resources/Datasources/dynamic_udfs/jars_local/update_function/after_update/* /user/$UDF_USER/drill/udf/staging/
