#!/bin/bash
# this will disable all services found by
# tvheadend since on european SAT DVB-S you
# will most likely get around 4000 services.
# Imagine you'd to have to click them all in order
# to disable them. D'oh.
#
# Oh, and it is going to disable all EPG fetching
# also to prevent tvheadend from switching to paytv
# and ask for keys just to update its EPG DB.

find ~/.hts/tvheadend/dvbtransports/ -type f  -print0 | xargs -0 sed -i 's/\"disabled\": 0/\"disabled\": 1/g'
find ~/.hts/tvheadend/dvbtransports/ -type f -print0 | xargs -0 sed -i  's/\"dvb_eit_enable\": 1/\"dvb_eit_enable\": 0/g'
