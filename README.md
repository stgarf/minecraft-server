# minecraft-server
A Minecraft server on Kubernetes

Use this to build the image that the Minecraft-Operator will run when a CustomResource is requested. 
You can use this standalone via the `depoy/` folder -- but it's meant to be used with [this Operator](http://github.com/stgarf/minecraft-operator-go).

## Usage
### 0. Tweak server version in Dockerfile as desired.

### 1. Build the minecraft-server image and push it to a registry (for use by minecraft-operator-go):
```sh
$ docker build . -t quay.io/example/minecraft-server:v1.13.2
$ docker push quay.io/example/minecraft-server:v1.13.2
```
