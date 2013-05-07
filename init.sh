#!/bin/sh

bi sample @config.conf @joint.conf --target joint --model-file Windkessel.bi --init-file data/init.nc --input-file data/input.nc --output-file data/obs.nc --start-time -24 --end-time 2.4 --noutputs 330 --seed -1
