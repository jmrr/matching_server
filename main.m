function bestMatchingFrames = main(queryFrame) %#codegen

[paramsDataset, paramsQuery] = setup();
bestMatchingFrames = getBestMatchingFrames(paramsDataset, paramsQuery, queryFrame);

end