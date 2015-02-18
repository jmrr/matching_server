# Visual path matching server #

Author:  Jose Rivera (jose.rivera@imperial.ac.uk)          

MATLAB headless server for matching incoming query frames. Takes the query frame, extracts dense SIFT features and performs a bag of visual words (BOVW) matching using the chi2 distance.

**Requirements**

VLFEAT: http://www.vlfeat.org

**Running instructions:**

On a shell, run


```
#!bash

sh matching_server.sh
```
