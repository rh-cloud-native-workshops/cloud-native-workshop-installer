#!/bin/sh

export REGISTRY=quay.io
export REGISTRY_USER_ID=cvicensa
export IMAGE_NAME=cnw-installer
export IMAGE_VERSION=v0.0.2

docker build -t $REGISTRY/$REGISTRY_USER_ID/$IMAGE_NAME:$IMAGE_VERSION .

docker push $REGISTRY/$REGISTRY_USER_ID/$IMAGE_NAME:$IMAGE_VERSION