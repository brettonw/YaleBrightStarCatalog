#!/usr/bin/env bash

bsc5.pl > bsc5-all.json 2> bsc5-all-err.txt
bsc5.pl 0-52 > bsc5-orig.json 2> bsc5-orig-err.txt
bsc5.pl "0-11,26-36,39-52,Notes,Category,Remark,RA,Dec,SpectralCls,LuminosityCls" > bsc5.json 2> bsc5-err.txt
bsc5.pl "HR,Flamsteed=F,Bayer=B,Common=N,RA,Dec,Vmag=V,K" > bsc5-short.json 2> bsc5-short-err.txt
