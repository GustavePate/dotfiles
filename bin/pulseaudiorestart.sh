#!/bin/bash
killall jackd
echo "stop"
pulseaudio -k
echo "start"
pulseaudio -D
