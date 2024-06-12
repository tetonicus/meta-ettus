#!/bin/bash

SAMPLE=/lib/systemd/network/40-int0.network.sample
LINK=/lib/systemd/network/40-int0.network
DATA=/data/network/int0.network

cp -f $SAMPLE $DATA
rm -f $LINK
ln -s $DATA $LINK
