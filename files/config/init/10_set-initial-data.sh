#! /bin/bash

if [ ! -f "/opt/csvn/data/conf/csvn.conf" ]; then
    cp -r /opt/csvn/data-initial/* /opt/csvn/data
fi
