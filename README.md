Commit Change-based Weighted Complex Network

Two source files are uploaded to this repository which supplement the paper titled - "A Commit Change-based Weighted Complex Network Approach to Identify Fault Prone Classes".

The first file, Co-change Script.sh, provide users a way to extract co-change behaviour from any Github repository and return in csv format which contains three column - Weight, Source, and Target. 
Users can specify the target repository by changing the "repository name" variable. The code also provide a way to specify the range of date for inspection by modifying the "SINCE" and "UNTIL" variable. 
The output csv which contains 3 columns can be easily exported to Cytoscape for further analysis by mapping the source node, target node, and weight of edges connecting two nodes. 

The second file, ChangeBurst.sh provide users a way to extract change burst information from any Github repository. The underlying working principle of change burst is based on the work by 

Nagappan, N., Zeller, A., Zimmermann, T., Herzig, K., & Murphy, B. (2010, November). Change bursts as defect predictors. In Software Reliability Engineering (ISSRE), 2010 IEEE 21st International Symposium on (pp. 309-318). IEEE.

Similar to the first file, users can specify the target repository and the range of inspection date by changing the provided variables. Users can also specify the gap size and burst size of the inspected code accordingly. 
The output of this script return a csv file which list down the maximum burst size and number of change burst for each and every file in the project. 
