# How to run?
Before running main.m script you need to download the related dataset from the DB mentioned in the report.
One way of doing this is by executing the mitdb shell script that is to be found in src.
After the MIT-BIH Arrhythmia Database has been downloaded you can proceed with running the main which will call the detector function.

# Stats
After the qrs files are produced you can generate stats by running multi.sh,
this script will take your eval.txt files (those will be produced after running main.m) and create stats summary from all signals.
