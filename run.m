function relativePosition = run(imgFilename) %#codegen

queryDescriptors  = dsift(imgFilename);
encodedQuery      = encodeHA(queryDescriptors);
bestMatchingFrame = matchAgainstDB(encodedQuery);
relativePosition  = getPositionFromFrame(bestMatchingFrame);

end