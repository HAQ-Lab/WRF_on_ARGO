#!/bin/bash
# run an interactive job to untar
# srun --mem 15g -t 0-04:00 -c 1 -N 1 --pty /bin/bash

# assign working directory
work_dir='/projects/HAQ_LAB/WRF_inputs/NARR/2017'

#assign WRF run directory
wrf_dir='/home/lhennem/lhennem/runWRF/2017'

# create seasonal subdirectories
mkdir -p $wrf_dir/run_wint
mkdir -p $wrf_dir/run_spri
mkdir -p $wrf_dir/run_summ
mkdir -p $wrf_dir/run_fall
mkdir -p $wrf_dir/run_wint/merge
mkdir -p $wrf_dir/run_spri/merge
mkdir -p $wrf_dir/run_summ/merge
mkdir -p $wrf_dir/run_fall/merge

# make a list of NARR .tar files
NARRtars=(`ls ${work_dir}/NARR*.tar`)

# assign months to seasons
mons_wint="01 02 03"
mons_spri="04 05 06"
mons_summ="07 08 09"
mons_fall="10 11 12"

# loop through files
for eachfile in ${NARRtars[*]}
do
   # isolate each month
   month=(`echo ${eachfile} | rev | cut -d"_" -f 2 | rev | cut -c5-6`)
   wrf_dir_seas='.'

   # check for winter
   for mon in {mons_wint[*]}; do
     if [[ $mon == "$month" ]]; then
        wrf_dir_seas=$wrf_dir/run_wint
     fi
   done

   # check for spring
   for mon in ${mons_spri[*]}; do
     if [[ $mon == "$month" ]]; then
        wrf_dir_seas=$wrf_dir/run_spri
     fi
   done

   # check for summer
   for mon in ${mons_summ[*]}; do
     if [[ $mon == "$month" ]]; then
        wrf_dir_seas=$wrf_dir/run_summ
        break     
     fi
   done

   # check for fall
   for mon in ${mons_fall[*]}; do
     if [[ $mon == "$month" ]]; then
        wrf_dir_seas=$wrf_dir/run_fall
     fi
   done

   # tar each file
   echo $eachfile
   tar -xvf $eachfile -C $wrf_dir_seas/merge

done





