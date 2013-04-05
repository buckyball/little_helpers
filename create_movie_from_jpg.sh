#!/bin/bash
#
#  find all jpegs from my front door surveillance cam
#  in the current directory and rename them with an 
#  ascending number to get them properly fed into 
#  ffmpg to create an mp4 movie file with 25 Frames/s
#
#  this is based on the default `find` behavior which 
#  lists the oldest file first.
find -name '*.jpg' | gawk 'BEGIN{ a=1 }{ printf "mv %s %04d.jpg\n", $0, a++ }' | bash
ffmpeg -r 25 -i %04d.jpg  movie_25_frames.mp4
