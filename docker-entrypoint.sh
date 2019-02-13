#!/bin/bash
echo "Initializing Minecraft server version $VERSION"

# Fetch given server version
echo "Fetching server.jar version: $VERSION"
curl -s https://launchermeta.mojang.com/mc/game/version_manifest.json | \
	jq --arg VERSION "$VERSION" -r '.versions[] | select(.id == $VERSION) \
	| {url} | .url' | xargs curl -s | jq -r '.downloads.server.url' | \
	xargs curl -so $USER/server.jar

# Handle license
#echo "eula=$EULA" >> /server-data/eula.txt
#if [ $? != 0 ]; then echo "ERROR: Persistent Volume Claim is unavailable!"; exit 2; fi

# Run server.jar with java command.
exec "$@"
