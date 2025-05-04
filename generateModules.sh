#!/bin/bash

set -e

readonly type=$1

cd MyTool

swift run MyTool ../Modules $type
