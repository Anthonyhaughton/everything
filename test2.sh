#!/bin/bash

# Data move for partition 00

rsync -av /mnt/ladata001/slow01/THEIA/IHTest_202009_DistStA /mnt/ladarpaih01/00/ --progress # Started 5/22/23 4:53PM # Done 5/23/23 10:00AM
rsync -av /mnt/ladata001/slow01/THEIA/IHTest_202104_DistStA /mnt/ladarpaih01/00/ --progress # Started 5/23/23 10:05AM # Done 5/24/23 11:30AM
rsync -av /mnt/ladata001/slow01/THEIA/IHTest_202104_DistStA_converted_lidar /mnt/ladarpaih01/00/ --progress # Stared 5/23/23 11:35AM # Done 11:40AM
rsync -av /mnt/ladata001/slow01/THEIA/IHTest_202108_DistStA /mnt/ladarpaih01/00/ --progress # Stared 5/24/23 11:45AM # Done 5/25/23 11:00AM 
rysnc -av /mnt/ladata001/slow01/THEIA/IHTest_202112_DistStA /mnt/ladarpaih01/00/ --progress # Stared 5/25/23 11:45AM # Done
rysnc -av /mnt/ladata001/slow01/THEIA/IHData_DistrA_Early_Maine_Data /mnt/ladarpaih01/00/ --progress # Done 5/30/23 10:43AM

# Data move for partition 10 Same name

rysnc -av /mnt/ladata001/slow01/THEIA/IHTest_202009_DistStD_ExpCont /mnt/ladarpaih01/01/ --progress # Done 5/30/23 11:09AM
rysnc -av /mnt/ladata001/slow01/THEIA/IHTest_202108_DistStD_ExpCont /mnt/ladarpaih01/01/ --progress # Done 5/31/23 9:09AM
rysnc -av /mnt/ladata001/slow01/THEIA/IHTest_202112_DistStD_ExpCont /mnt/ladarpaih01/01/ --progress # Done 5/31/23 11:29AM

# Data move for partition 01 transfer1 folder

rysnc -av /mnt/ladata001/slow01/THEIA/transfer1/IHTest_202104_DistStD_ExpCont_Part1/ /mnt/ladarpaih01/01/IHTest_202104_DistStD_ExpCont/ --progress # Done 5/31/23 4:00PM
rysnc -av /mnt/ladata001/slow01/THEIA/transfer1/IHTest_202104_CalSuite_DistStD_ExpCont /mnt/ladarpaih01/01/ --progress # Done 6/1/23

rsync -av /mnt/ladata001/slow01/THEIA/transfer1/IHTest_202104_SummaryOfDataset_Appendix2_DistStD.docx /mnt/ladarpaih01/01/IHTest_202104_auxiliary_DistStD_ExpCont --progress # Done
rsync -av /mnt/ladata001/slow01/THEIA/transfer1/MD5Verifications.csv /mnt/ladarpaih01/01/IHTest_202104_auxiliary_DistStD_ExpCont --progress # Done
rsync -av /mnt/ladata001/slow01/THEIA/transfer1/ReadMe_DistStD_ExpCont.txt /mnt/ladarpaih01/01/IHTest_202104_auxiliary_DistStD_ExpCont --progress # Done
rsync -av /mnt/ladata001/slow01/THEIA/transfer1/APRICORN /mnt/ladarpaih01/01/IHTest_202104_auxiliary_DistStD_ExpCont --progress # Done
rsync -av /mnt/ladata001/slow01/THEIA/transfer1/transfer1/System\ Volume\ Information /mnt/ladarpaih01/01/IHTest_202104_auxiliary_DistStD_ExpCont --progress # Done

# Data move for partition 01 transfer2 folder

rsync -av /mnt/ladata001/slow01/THEIA/transfer2/IHTest_202104_DistStD_ExpCont_Part2/ /mnt/ladarpaih01/01/IHTest_202104_DistStD_ExpCont --progress # Done
rsync -av /mnt/ladata001/slow01/THEIA/transfer2/IHTest_202104_ExtraPaths_DistStD_ExpCont_Part2/ /mnt/ladarpaih01/01/IHTest_202104_ExtraPaths_DistStD_ExpCont --progress # Done 6/1/2023

# Skipping /APRICORN and /System Volume Information in transfer2

# Data move for partition 01 transfer3 folder

rsync -av /mnt/ladata001/slow01/THEIA/transfer3/IHTest_202104_ExtraPaths_DistStD_ExpCont_Part1/ root@ladarpaih01://mnt/ladarpaih01/01/IHTest_202104_DistStD_ExpCont --progress # Done 6/2/23

# Skipping /APRICORN and /System Volume Information in transfer3

# Indiviual directories that need to be copied. Need the target location

rsync -av /mnt/ladata001/slow01/THEIA/DIRSIG_DNN root@ladarpaih01://mnt/ladarpaih01/## --progress # Done
rsync -av /mnt/ladata001/slow01/THEIA/DIRSIG_materials root@ladarpaih01://mnt/ladarpaih01/## --progress # Done
rsync -av /mnt/ladata001/slow01/THEIA/DIRSIG_Sims root@ladarpaih01://mnt/ladarpaih01/## --progress # Done
rsync -av /mnt/ladata001/slow01/THEIA/DNN_weights root@ladarpaih01://mnt/ladarpaih01/## --progress # Done
rsync -av /mnt/ladata001/slow01/THEIA/Kitware_Calibration root@ladarpaih01://mnt/ladarpaih01/## --progress # Done
rsync -av /mnt/ladata001/slow01/THEIA/LACHI_spectra root@ladarpaih01://mnt/ladarpaih01/## --progress # Done
rsync -av /mnt/ladata001/slow01/THEIA/lastools root@ladarpaih01://mnt/ladarpaih01/## --progress # Done
rsync -av /mnt/ladata001/slow01/THEIA/users root@ladarpaih01://mnt/ladarpaih01/## --progress # Done



#[root@ladata001 THEIA]# du -lh -d1
# 1020M   ./LACHI_spectra
# 2.4G    ./IHData_DistrA_Early_Maine_Data
# 2.6T    ./DIRSIG_DNN
# 275G    ./DIRSIG_Sims
# 17G     ./IHTest_202104_DistStA_converted_lidar
# 7.6T    ./IHTest_202104_DistStA
# 1.2T    ./transfer2
# 1.8T    ./transfer1
# 265M    ./DNN_weights
# 64M     ./IRAD
# 990G    ./IHTest_202108_DistStD_ExpCont
# 212M    ./lastools
# 8.0K    ./transfer4
# 132G    ./IHTest_202009_DistStD_ExpCont
# 538G    ./IHTest_202112_DistStD_ExpCont
# 7.6M    ./Kitware_Calibration
# 8.2T    ./IHTest_202108_DistStA
# 266G    ./users
# 874G    ./IHTest_202009_DistStA
# 6.9T    ./IHTest_202112_DistStA
# 1.8T    ./transfer3
# 137M    ./DIRSIG_materials
# 33T     .
# 1.8T    ./IHTest_202104_DistStD_ExpCont_Part1
