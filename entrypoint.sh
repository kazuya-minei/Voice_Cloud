#!/bin/bash
set -e

# server.pidファイルを削除
rm -f /voice-cloud/tmp/pids/server.pid

# コンテナのメインプロセス（DockerfileでCMDとして設定されているもの）を実行。
exec "$@"