#=========================PARAMETERS====================================#
REPOSITORY_NAME=kairosdb
GAP_SIZE=3
BURST_SIZE=3
SINCE=1/1/2016
UNTIL=1/1/2017
DIFF_FILTER=MA #Modified and Added file
#====================GENERATE OUTPUT FILE===============================#
cd $REPOSITORY_NAME
#List of date followed by files affected respectively
git log --since=$SINCE --until=$UNTIL --pretty=format:'%at' --name-only --diff-filter=$DIFF_FILTER | 
#Remove the directory path and get only file name
awk 'BEGIN{ FS="/" } /^[0-9]+$/{print} /^$|\.java$/{ print $NF }' | 
#Copy date beside each file
awk 'BEGIN{ RS=""; FS="\n" } { for(i=2;i<=NF;i++)print $i,$1;} ' | 
sort |
awk -v GAP_SIZE=$GAP_SIZE -v BURST_SIZE=$BURST_SIZE '
#AWK COMMAND
BEGIN{
    print "FILES,MAXIMUM BURST SIZE,NUMBER OF CHANGE BURST"
}            
{
    if($1 != prev_file ){
        if( NR>1 )
            print prev_file","MAX_CHANGE_BURST","CHANGE_BURST_COUNT;      
        prev_file=$1;
        CONSECUTIVE_CHANGE=1;
        MAX_CHANGE_BURST=0;
        CHANGE_BURST_COUNT=0;
    }
    else{
        TIME_DIFF=int(($2-prev_time)/86400);
        if(TIME_DIFF<=GAP_SIZE)
            CONSECUTIVE_CHANGE++;
        else  
            CONSECUTIVE_CHANGE=1;
                                          	
    }
    if(CONSECUTIVE_CHANGE == BURST_SIZE)
        CHANGE_BURST_COUNT++;
    if(CONSECUTIVE_CHANGE>MAX_CHANGE_BURST && CONSECUTIVE_CHANGE>=BURST_SIZE)
        MAX_CHANGE_BURST=CONSECUTIVE_CHANGE;  
    prev_time=$2;
}
END{
    if(prev_file!="")
        print prev_file","MAX_CHANGE_BURST","CHANGE_BURST_COUNT
}
' > ${REPOSITORY_NAME}_Change_Burst.csv

#================================VERIFICATION==============================#
git log --since=$SINCE --until=$UNTIL --date=short --pretty=format:'%ad' --name-only --diff-filter=$DIFF_FILTER|
awk 'BEGIN{ FS="/" } /^[0-9]+/{print} /^$|\.java$/{ print $NF}' | #Remove the directory path and get only file name
awk 'BEGIN{ RS=""; FS="\n" } { for(i=2;i<=NF;i++)if(!match($i,/^[0-9]+.*[0-9]+$/))print $i","$1;} ' |
sort >${REPOSITORY_NAME}_Date_List.csv