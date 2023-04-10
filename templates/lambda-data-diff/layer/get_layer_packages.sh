#!/bin/bash

rm -rf python && mkdir -p python

docker run --rm -v $(pwd):/foo -w /foo lambci/lambda:build-python3.8 pip install -r requirements.txt -t python

zip -r python-custom-layer.zip .
