#!/bin/bash
# Matching server based on DISFT and Hard Assignment
# Requires VLFEAT http://www.vlfeat.org/
# Jose Rivera - Feb' 15

# Run MATLAB headless and close it afterwards

matlab -nojvm -nodisplay -nosplash -r "matchingServer('test.jpg'), exit"



