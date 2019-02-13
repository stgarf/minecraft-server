#!/bin/bash
echo "Initializing Minecraft server version $VERSION"

# Fetch given server version
echo "Fetching server.jar version: $VERSION"
pushd $HOME && \
	curl -sL https://launchermeta.mojang.com/mc/game/version_manifest.json | \
	jq --arg VERSION "$VERSION" -r \
	'.versions[] | select(.id == $VERSION) | {url} | .url' | xargs curl -sL | \
	jq -r '.downloads.server.url' | xargs curl -sLO && \
	popd

# Handle license
if [ -f /server-data/eula.txt ]; then
	sed -i 's/eula=false/eula=true/g' /server-data/eula.txt
else
	echo "eula=$EULA" >> /server-data/eula.txt
fi

if [ $? != 0 ]; then echo "ERROR: Persistent Volume Claim is unavailable!"; exit 2; fi

# Run server.jar with java command.
exec "$@"
