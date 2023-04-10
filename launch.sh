#!/bin/bash

set -x

cd /data

if ! [[ "$EULA" = "false" ]] || grep -i true eula.txt; then
	echo "eula=true" > eula.txt
else
	echo "You must accept the EULA by adding EULA=true to the container environment settings."
	exit 9
fi

# Clean up previous deployments
rm -rf ./config  ./defaultconfigs ./mods ./packmenu ./patchouli_books  ./scripts
# Install the server files of the current update
cp -rf /server/* /data/

# Install the server properties ONLY if it doesn't already exist so that modification are not lost
if [ ! -e server.properties ]; then
    cp /server.properties /data/
fi

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" server.properties
fi
if [[ -n "$LEVEL" ]]; then
    sed -i "/level-name\s*=/ c level-name=$LEVEL" server.properties
fi
if [[ -n "$LEVELTYPE" ]]; then
    sed -i "/level-type\s*=/ c level-type=$LEVELTYPE" server.properties
fi
if [[ -n "$LEVELSEED" ]]; then
    sed -i "/level-seed\s*=/ c level-seed=$LEVELSEED" server.properties
fi
if [[ -n "$GAMEMODE" ]]; then
    sed -i "/gamemode\s*=/ c gamemode=$GAMEMODE" server.properties
fi
if [[ -n "$DIFFICULTY" ]]; then
    sed -i "/difficulty\s*=/ c difficulty=$DIFFICULTY" server.properties
fi

if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' >> ops.txt
fi

if [ ! -e user_jvm_args.txt ]; then
    {
    	echo "# WARNING: AUTO-GENERATED"
    	echo "# WARNING: Use the container environment variable JVM_OPTS"
    	echo "$JVM_OPTS"
    } > user_jvm_args.txt
fi

# Call the AllTheMods start script
./startserver.sh
