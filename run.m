function bestMatchingFrame = run(imgFilename) %#codegen

queryDescriptors = dsift(imgFilename);
[encodedQuery] = encodeHA(queryDescriptors);
bestMatchingFrame = matchAgainstDB(encodedQuery);

end