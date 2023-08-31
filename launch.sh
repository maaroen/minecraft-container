#!/bin/bash

set -x

cd /data

if ! [[ "$EULA" = "false" ]] || grep -i true eula.txt; then
	echo "eula=true" > eula.txt
else
	echo "You must accept the EULA by adding EULA=true to the container environment settings."
	exit 9
fi

# If you want to clean install all config files and mods in your server, specify NUCLEAR_UPDATE=TRUE
# Please backup your config files before setting this
if [[ -n "$NUCLEAR_UPDATE" ]]; then
    # Clean up previous deployments
    rm -rf ./config  ./defaultconfigs ./mods ./packmenu ./patchouli_books  ./scripts
    # Install the server files of the current update
    cp -rf /server/* /data/
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
if [[ -n "$WHITELIST_ENABLED" ]]; then
    sed -i "/white-list\s*=/ c white-list=$WHITELIST_ENABLED" server.properties
fi

if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' >> ops.txt
fi

# On every start, update the Java command line options
{
	echo "# WARNING: AUTO-GENERATED"
	echo "# WARNING: Use the container environment variable JVM_OPTS"
	echo "$JVM_OPTS"
} > user_jvm_args.txt

# Call the Vault Hunters start script
/server/start.sh
