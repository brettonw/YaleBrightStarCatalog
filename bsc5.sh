#!/usr/bin/env bash

bsc5.pl > bsc5.json 2> bsc5-err.txt
bsc5.pl "HR,FlamsteedA=Flamsteed,BayerA=Bayer,Common,RA,Dec,Vmag=V,B-V,U-B,SpType=Spectral Type" > bsc5-short.json 2> bsc5-short-err.txt
