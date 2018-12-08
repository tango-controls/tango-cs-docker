#!/bin/bash

docker build --tag tango-build -f .travis/Dockerfile .

docker network create tango-build

docker run --network name mysql mysql/server:5.6

docker run --network tango-build tango-build

