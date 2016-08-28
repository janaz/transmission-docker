#!/bin/bash

echo -e "$TR_TIME_LOCALTIME\t$TR_TORRENT_NAME\t$TR_TORRENT_ID\t$TR_TORRENT_HASH\t$TORRENT_DIR\t$APP_VERSION" >> /tmp/completed.txt
