#WRF Installation on ARGO Cluster

# here i've written WRF installation procedure baseon on this following youtube tutorial

#https://www.youtube.com/watch?v=mNsJM-X4ZYE&list=PLRymTaM7hlGOh9FPTalCtR3dHXGe3jbBt&index=3&ab_channel=MeteoAdriatic


#Compiler choice : gfortran/gcc


#compiler time dependencies (libraries)

#1.	NETCDF 4.1.2
#2.	LINPNG 1.6.37
#3.	ZLIB 1.2.11
#4.	JASPER 1.900.1
#5.	Mpich 3.3.2


#login into argo cluster account using your id and password

#goto this directory  /projects/HAQ_LAB/mrasel using following command:

cd /projects/HAQ_LAB/mrasel

#here i've chosen mrasel, one can create their own directory under HAQ_LAB

#make directory wrf using: 

mkdir wrf

cd wrf

mkdir WRF

cd WRF

mkdir downloads 

#(here we'll download our libraries, WRF and WPS source codes)

cd downloads

#now we'll start downloading libraries and WRF WPS source code inside of downloads directory

wget ftp://ftp.unidata.ucar.edu/pub/netcdf/old/netcdf-4.1.2.tar.gz

wget https://download.sourceforge.net/libpng/libpng-1.6.37.tar.gz

wget https://zlib.net/zlib-1.2.11.tar.gz

wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-1.900.1.tar.gz

wget https://www.mpich.org/static/downloads/3.3.2/mpich-3.3.2.tar.gz

wget https://github.com/wrf-model/WRF/archive/v4.2.1.tar.gz

wget https://github.com/wrf-model/WPS/archive/v4.2.tar.gz


#now check if we've gcc/fortran c compiler or not. to check write on terminal:

which gcc

#if gcc is already installed then it'll show the installtion path. otherwise we have to download and install it

#extracting all downloaded files

for i in *.gz; do tar xzf $i ; done

#now goto /projects/HAQ_LAB/mrasel/wrf/WRF

mkdir libs

# (outside of downloads directory: here we’ll store installed libraries files)


#now inside of libs directory create folder netcdf, mpich and grib2 

mkdir netcdf mpich grib2

#grib2 is a file format that meteorological data are distributed in

#Now on terminal create a variable LIBDIR which is just path of libs directory (so that we don’t have to use the path name over and over again)

export LIBDIR=/projects/HAQ_LAB/mrasel/wrf/WRF/libs

#to check the path of LIBDIR: 
echo $LIBDIR

#for LIBPNG I need to use ZLIB so that I’ll first compile ZLIB

#now use terminal and goto downloads folder of WRF and then 

#goto 

cd /projects/HAQ_LAB/mrasel/wrf/WRF/downloads

cd zlib-1.2.11

./configure --prefix=$LIBDIR/grib2

make
make install 
#(this command will take compiled library to our mentioned folder grib2)

cd ..

cd libpng-1.6.37

#we need to configure it but at the same time we need to specify path of zlib. Libpng need to use zlib that we installed in earlier step


./configure --prefix=$LIBDIR/grib2 LDFLAGS="-L$LIBDIR/grib2/lib" CPPFLAGS="-I$LIBDIR/grib2/include"


make
make install
cd ..


cd jasper-1.900.1

./configure --prefix=$LIBDIR/grib2


make
make install
cd ..

cd netcdf-4.1.2

./configure --prefix=$LIBDIR/netcdf --disable-dap --disable-netcdf-4
#(we’re installing part of netcdf; not all of them)

make
make install
cd ..




cd mpich-3.3.2

./configure --prefix=$LIBDIR/mpich

make
make install
cd ..


#take WPS-4.2  WRF-4.2.1 folder from downloads folder to outside of download folder (/projects/HAQ_LAB/mrasel/wrf/WRF/)

cd WRF-4.2.1

export LIBDIR=/projects/HAQ_LAB/mrasel/wrf/WRF/libs 
#(we can use LIBDIR for easy input)

export NETCDF=$LIBDIR/netcdf 
#(compilation path set for netcdf)


export PATH= $LIBDIR/mpich/bin:$PATH

echo $PATH


#to check: which mpicc (it'll show path)

echo $NETCDF

export  JASPERLIB=$LIBDIR/grib2/lib
export JASPERINC=$LIBDIR/grib2/include

./configure

#Select 34 then 1 (dmpar gfortran/gcc and basic)

#We’ll get a file configure.wrf in that folder (/projects/HAQ_LAB/mrasel/wrf/WRF/WRF-4.2.1/)

which mpi90

which time

./compile em_real

export LD_LIBRARY_PATH=$LIBDIR/netcdf/lib:$LD_LIBRARY_PATH
cd main/

./wrf.exe

./real.exe

#(starting wrf task o of 1… it means wrf has installed successfully)


cd /projects/HAQ_LAB/mrasel/wrf/WRF/WPS-4.2

export WRF_DIR=/projects/HAQ_LAB/mrasel/wrf/WRF/WRF-4.2.1


./configure

3

#Now we’ll have configure.wps inside of /projects/HAQ_LAB/mrasel/wrf/WRF/WPS-4.2 directory

./compile

ls

#we'll have these 3 files;

#./geogrid.exe
#./ungrib.exe
#./metgrid.exe

#I need to set path of LD_LIBRARY permanently other wise I'll have to run export LD_LIBRARY_PATH=$LIBDIR/netcdf/lib:$LD_LIBRARY_PATH everytime i open terminal

cd 

#(it'll take to me home directory. everytime i login into argo, i want this following path to load automatically)


vi .bashrc

#at the End of the file put the path

export LD_LIBRARY_PATH=/projects/HAQ_LAB/mrasel/wrf/WRF/libs/netcdf/lib:$LD_LIBRARY_PATH

export PATH=/projects/HAQ_LAB/mrasel/wrf/WRF/libs/mpich/bin:$PATH

export LD_LIBRARY_PATH= /projects/HAQ_LAB/mrasel/wrf/WRF/libs/grib2/lib:/projects/HAQ_LAB/mrasel/wrf/WRF/libs/netcdf/lib:/lib64
export PATH=/projects/HAQ_LAB/mrasel/wrf/WRF/libs/mpich/bin:$PATH



:wq 

#(to save and quit)


#reopen terminal and login into cluster using user id and password and now check library path
which mpirun
cd projects/HAQ_LAB/wrf/WRF/wrf-4.1/main
./wrf.exe
#it'll show starting 0 of 1 task...


#now goto 

cd /projects/HAQ_LAB/mrasel/wrf/WRF/


#downloading Static Geography Data

mkdir geog

cd geog

wget https://www2.mmm.ucar.edu/wrf/src/wps_files/geog_high_res_mandatory.tar.gz

tar xzf geog_high_res_mandatory.tar.gz 




#Wps manual here: https://www2.mmm.ucar.edu/wrf/users/docs/user_guide_v4/v4.2/users_guide_chap3.html

#Inside of WPS folder file name namelist.wps file is the file where we can change parameters


#now I’ve moved all the files from inside of WPS_geog folder to geog folder (/projects/HAQ_LAB/mrasel/wrf/WRF/geog) and then deleted wps_geog folder

#Goto WPS directory (/projects/HAQ_LAB/mrasel/wrf/WRF/WPS-4.2) and open namelist.wps

#Max_dom is telling system how many nesting level we want

#Then I changed these parameters for initial test

max_dom = 1,
 start_date = '2006-08-16_12:00:00','2006-08-16_12:00:00',
 end_date   = '2006-08-16_18:00:00','2006-08-16_12:00:00',
 interval_seconds = 21600
 io_form_geogrid = 2,
/

&geogrid
 parent_id         =   1,   1,
 parent_grid_ratio =   1,   3,
 i_parent_start    =   1,  31,
 j_parent_start    =   1,  17,
 e_we              =  100, 112,
 e_sn              =  100,  97,
 geog_data_res = 'default','default',
 dx = 10000,
 dy = 10000,
 map_proj = 'lambert',
 ref_lat   =  37.00,
 ref_lon   =  -95.00,
 truelat1  =  37.0,
 truelat2  =  37.0,
 stand_lon =  -95.0,
 geog_data_path = '/projects/HAQ_LAB/mrasel/wrf/WRF/geog'
/


#Go to WPS directory (/projects/HAQ_LAB/mrasel/wrf/WRF/WPS-4.2)

./geogrid.exe

ls

#There will be a file named geo_em.d01.nc


#ncview geo_em.d01.nc (ncview needs to be installed on cluster to see .nc files)


#Downloading GFS data

cd /projects/HAQ_LAB/mrasel/wrf/WRF/scripts

#here i'll write down scripts to download GFS files automatically

#Goto https://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/

#Downloading GFS data to use metgrid ungrib command

#for example, I chose gfs.20201117/00

#https://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.20201117/00/

#open a text editor or .sh script

#!/bin/bash


server = https://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod

directory = gfs.20201117/00

file = gfs.t00z.pgrb2.0p50.f000

url = $ {server}/${directory}/${file}

echo $url

#save file as download_gfs.sh

#goto terminal 

chmod +x download_gfs.sh

./download_gfs.sh


#we'll have 3 files:

#gfs.t00z.pgrb2.0p50.f000  
#gfs.t00z.pgrb2.0p50.f003 
#gfs.t00z.pgrb2.0p50.f006

#or 

#just downloaded manually 0.5 degree files

#gfs.t00z.pgrb2.0p50.f000  
#gfs.t00z.pgrb2.0p50.f003 
#gfs.t00z.pgrb2.0p50.f006


#link to the correct Vtable (GFS, for this case):

ln -s ungrib/Variable_Tables/Vtable.GFS ./Vtable

#linking in the input GFS data

./link_grib.csh /projects/HAQ_LAB/mrasel/wrf/WRF/GFS/

#Now you will see 3 files GRIBFILE.AAA GRIBFILE.AAB GRIBFILE.AAC



#Goto wps folder (/projects/HAQ_LAB/mrasel/wrf/WRF/WPS-4.2) and open namelist.wps file to change start date and end date

start_date = '2020-11-17_00:00:00','2006-08-16_12:00:00',
end_date   = '2020-11-17_06:00:00','2006-08-16_12:00:00',
interval_seconds = 10800

#Interval seconds 3x60x60 = 10800


#Now 
./ungrib.exe

#Now 

ls

#We’ll have 3 files 

#FILE:2020-11-17_06 FILE:2020-11-17_03 FILE:2020-11-17_00

ln -s metgrid/METGRID.TBL.ARW ./METGRID.TBL

./metgrid.exe

#We’ll have 3 files

met_em.d01.2020-11-17_00:00:00.nc
met_em.d01.2020-11-17_03:00:0.nc
met_em.d01.2020-11-17_06:00:00.nc



#geo_em is static geography file

#met_em is meteorology file

#we can view nc file using ncview command (need to talk to cluster people to install ncview)


#Running real and wrf

#Real.exe wrf will create initial and boundary condition of atmosphere (met_em file will be used here)

#wrf.exe then will integrate through time and simulate how atmosphere will develop

#Linking met to wrf-run

ln -s /projects/HAQ_LAB/mrasel/wrf/WRF/WPS-4.2/met_em* .

ls

#check if linking has done properly by using mc commander and check linking directory

#open namelist.input file using text editor inside of run folder of WRF directory (/projects/HAQ_LAB/mrasel/wrf/WRF/WRF-4.2.1/run)

#several sections

#time , domain, dynamics, physics section

#also open namelist.wps file from WPS directory. We need some information from here to input in namelist.input file

#time section first column change. We can neglect others since we’re using 1 domain only


#for example: (inside of namelist.input file)

&time_control
 run_days                            = 0,
 run_hours                           = 6,
 run_minutes                         = 0,
 run_seconds                         = 0,
 start_year                          = 2020, 2000, 2000,
 start_month                         = 11,   01,   01,
 start_day                           = 17,   24,   24,
 start_hour                          = 00,   12,   12,
 end_year                            = 2020, 2000, 2000,
 end_month                           = 11,   01,   01,
 end_day                             = 17,   25,   25,
 end_hour                            = 06,   12,   12,
 interval_seconds                    = 10800
 input_from_file                     = .true.,.true.,.true.,
 history_interval                    = 60,  60,   60,
 frames_per_outfile                  = 1, 1000, 1000,
 restart                             = .false.,
 restart_interval                    = 7200,
 io_form_history                     = 2
 io_form_restart                     = 2
 io_form_input                       = 2
 io_form_boundary                    = 2
 /

 &domains
 time_step                           = 60,
 time_step_fract_num                 = 0,
 time_step_fract_den                 = 1,
 max_dom                             = 1,
 e_we                                = 100,    112,   94,
 e_sn                                = 100,    97,    91,
 e_vert                              = 40,    33,    33,
 p_top_requested                     = 5000,
 num_metgrid_levels                  = 34,
 num_metgrid_soil_levels             = 4,
 dx                                  = 10000,
 dy                                  = 10000,
 grid_id                             = 1,     2,     3,
 parent_id                           = 0,     1,     2,
 i_parent_start                      = 1,     31,    30,
 j_parent_start                      = 1,     17,    30,
 parent_grid_ratio                   = 1,     3,     3,
 parent_time_step_ratio              = 1,     3,     3,
 feedback                            = 1,
 smooth_option                       = 0
 /

 &physics
 !physics_suite                       = 'CONUS'
 mp_physics                          = 3,    -1,    -1,
 cu_physics                          = 1,    -1,     0,
 ra_lw_physics                       = 1,    -1,    -1,
 ra_sw_physics                       = 1,    -1,    -1,
 bl_pbl_physics                      = 1,    -1,    -1,
 sf_sfclay_physics                   = 1,    -1,    -1,
 sf_surface_physics                  = 1,    -1,    -1,
 radt                                = 30,    30,    30,
 bldt                                = 0,     0,     0,
 cudt                                = 5,     5,     5,
 icloud                              = 1,
 num_land_cat                        = 21,
 sf_urban_physics                    = 0,     0,     0,
 /

 &fdda
 /

 &dynamics
 hybrid_opt                          = 2, 
 w_damping                           = 1,
 diff_opt                            = 1,      1,      1,
 km_opt                              = 4,      4,      4,
 diff_6th_opt                        = 0,      0,      0,
 diff_6th_factor                     = 0.12,   0.12,   0.12,
 base_temp                           = 290.
 damp_opt                            = 3,
 zdamp                               = 5000.,  5000.,  5000.,
 dampcoef                            = 0.2,    0.2,    0.2
 khdif                               = 0,      0,      0,
 kvdif                               = 0,      0,      0,
 non_hydrostatic                     = .true., .true., .true.,
 moist_adv_opt                       = 1,      1,      1,     
 scalar_adv_opt                      = 1,      1,      1,     
 gwd_opt                             = 0,      1,      0,
 /

 &bdy_control
 spec_bdy_width                      = 5,
 specified                           = .true.
 /

 &grib2
 /

 &namelist_quilt
 nio_tasks_per_group = 0,
 nio_groups = 1,
 /


#Run hours should be 6 since we are running for 6 hrs here


#Save it

#Use mpirun for multiprocessing

#To see how many processor we have cat /proc/cpuinfo

mpirun -n 8 ./real.exe

#(8 for 8 cores bt I can change it)
#To check if it worked type mc

#you can check wrfbdy and wrfinput file using ncview (install at cluster)


#now run wrf.exe

mpirun -n 8 ./wrf.exe

#to check if its running open another window

#goto run folder

#tail -F rsl.out.0006 or htop







