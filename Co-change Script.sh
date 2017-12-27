repository_name=kairosdb
SINCE=1/1/2016
UNTIL=1/1/2017
cd $repository_name
git log -r  --since=$SINCE --until=$UNTIL --name-only --pretty=format:'' | 
awk 'BEGIN{ FS="/" } /^$|\.m$|\.java$/{ print $NF}' | #Remove the directory path and get only file name
awk 'BEGIN{ RS="" ; FS="\n"} { for(i=1;i<=NF;i++) for(j=1;j<i;j++) print $i,$j}' | #Print Source Target Pair
sort | uniq -c | sed -e 's/^ *//;s/ /,/g' | #Count Number of Occurence 
awk 'BEGIN{ print "Weight,Source,Target"} {print}' > ${repository_name}_Edges.csv

