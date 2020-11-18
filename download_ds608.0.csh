#!/bin/csh
#################################################################
# Csh Script to retrieve 37 online Data files of 'ds608.0',
# total 24.28G. This script uses 'wget' to download data.
#
# Highlight this script by Select All, Copy and Paste it into a file;
# make the file executable and run it on command line.
#
# You need pass in your password as a parameter to execute
# this script; or you can set an environment variable RDAPSWD
# if your Operating System supports it.
#
# Contact chifan@ucar.edu (Chi-Fan Shih) for further assistance.
#################################################################


set pswd = $1
if(x$pswd == x && `env | grep RDAPSWD` != '') then
 set pswd = $RDAPSWD
endif
if(x$pswd == x) then
 echo
 echo Usage: $0 YourPassword
 echo
 exit 1
endif
set v = `wget -V |grep 'GNU Wget ' | cut -d ' ' -f 3`
set a = `echo $v | cut -d '.' -f 1`
set b = `echo $v | cut -d '.' -f 2`
if(100 * $a + $b > 109) then
 set opt = 'wget --no-check-certificate'
else
 set opt = 'wget'
endif
set opt1 = '-O Authentication.log --save-cookies auth.rda_ucar_edu --post-data'
set opt2 = "email=lhenneman@gmail.com&passwd=$pswd&action=login"
$opt $opt1="$opt2" https://rda.ucar.edu/cgi-bin/login
set opt1 = "-N --load-cookies auth.rda_ucar_edu"
set opt2 = "$opt $opt1 https://rda.ucar.edu/data/ds608.0/"
set filelist = ( \
  3HRLY/2017/NARR3D_201706_1618.tar \
  3HRLY/2017/NARR3D_201706_1921.tar \
  3HRLY/2017/NARR3D_201706_2224.tar \
  3HRLY/2017/NARR3D_201706_2527.tar \
  3HRLY/2017/NARR3D_201706_2830.tar \
  3HRLY/2017/NARRclm_201706_0130.tar \
  3HRLY/2017/NARRflx_201706_0108.tar \
  3HRLY/2017/NARRflx_201706_0916.tar \
  3HRLY/2017/NARRflx_201706_1724.tar \
  3HRLY/2017/NARRflx_201706_2530.tar \
  3HRLY/2017/NARRpbl_201706_0109.tar \
  3HRLY/2017/NARRpbl_201706_1019.tar \
  3HRLY/2017/NARRpbl_201706_2030.tar \
  3HRLY/2017/NARRsfc_201706_0109.tar \
  3HRLY/2017/NARRsfc_201706_1019.tar \
  3HRLY/2017/NARRsfc_201706_2030.tar \
  3HRLY/2017/NARR3D_201707_0103.tar \
  3HRLY/2017/NARR3D_201707_0406.tar \
  3HRLY/2017/NARR3D_201707_0709.tar \
  3HRLY/2017/NARR3D_201707_1012.tar \
  3HRLY/2017/NARR3D_201707_1315.tar \
  3HRLY/2017/NARR3D_201707_1618.tar \
  3HRLY/2017/NARR3D_201707_1921.tar \
  3HRLY/2017/NARR3D_201707_2224.tar \
  3HRLY/2017/NARR3D_201707_2527.tar \
  3HRLY/2017/NARR3D_201707_2831.tar \
  3HRLY/2017/NARRclm_201707_0131.tar \
  3HRLY/2017/NARRflx_201707_0108.tar \
  3HRLY/2017/NARRflx_201707_0916.tar \
  3HRLY/2017/NARRflx_201707_1724.tar \
  3HRLY/2017/NARRflx_201707_2531.tar \
  3HRLY/2017/NARRpbl_201707_0109.tar \
  3HRLY/2017/NARRpbl_201707_1019.tar \
  3HRLY/2017/NARRpbl_201707_2031.tar \
  3HRLY/2017/NARRsfc_201707_0109.tar \
  3HRLY/2017/NARRsfc_201707_1019.tar \
  3HRLY/2017/NARRsfc_201707_2031.tar \
)
while($#filelist > 0)
 set syscmd = "$opt2$filelist[1]"
 echo "$syscmd ..."
 $syscmd
 shift filelist
end

