#!/bin/sh

set -e

id omadad

# set default time zone and notify user of time zone
export TZ
TZ="${TZ:-Etc/UTC}"
echo "INFO: Time zone set to '${TZ}'"

# make sure permissions are set appropriately on each directory
for DIR in data work logs
do
  OWNER="$(stat -c '%u' /opt/tplink/OmadaController/${DIR})"
  GROUP="$(stat -c '%g' /opt/tplink/OmadaController/${DIR})"

  if [ "${OWNER}" != "508" ] || [ "${GROUP}" != "508" ]
  then
    # notify user that uid:gid are not correct and fix them
    echo "WARNING: owner or group (${OWNER}:${GROUP}) not set correctly on '/opt/tplink/OmadaController/${DIR}'"
    echo "INFO: setting correct permissions"
    chown -R 508:508 "/opt/tplink/OmadaController/${DIR}"
  fi
done

# check to see if there is a db directory; create it if it is missing
if [ ! -d "/opt/tplink/OmadaController/data/db" ]
then
  echo "INFO: Database directory missing; creating '/opt/tplink/OmadaController/data/db'"
  mkdir /opt/tplink/OmadaController/data/db
  chown 508:508 /opt/tplink/OmadaController/data/db
  echo "done"
fi

#export JAVA_HOME=/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/jre
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-armhf/jre

echo "INFO: Starting Omada Controller"
set -x
exec gosu omadad "${@}"
