function bestMatchingFrames = getBestMatchingFrames(paramsDataset, paramsQuery, queryFrame) %#codegen

passes      = paramsDataset.passes;
trainingSet = passes(1:paramsQuery.queryPass-1,paramsQuery.queryPass+1:end);
numTopMatches = 1; % Only top match for now

% kernelMatFileName = ['C2_db' convertnum(trainingSet(1)) '_q' convertnum(paramsQuery.queryPass)]; % HARDCODED 1
% kernelFileName = ['data/'  kernelMatFileName];
kernelFileName = 'C2_db1_q2';
kernelStruct   = coder.load(kernelFileName,'kernel');

kernel = kernelStruct.kernel;

scores = kernel(queryFrame,:);
[sortedScr, idx] = sort(scores,'descend');

top        = sortedScr(1:numTopMatches);
topIdx     = idx(1:numTopMatches);

bestMatchingFrames = topIdx;


end