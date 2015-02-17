function bestMatchingFrames = getBestMatchingFrames(paramsDataset, paramsQuery, queryFrame) %#codegen


passes      = paramsDataset.passes;
trainingSet = passes(1:paramsQuery.queryPass-1,paramsQuery.queryPass+1:end);

numTopMatches = 1; % Only top match for now
numKernels = length(trainingSet);
top        = zeros(numKernels,numTopMatches);
topIdx     = zeros(size(top));


for i = 1:numKernels
    
    %     kernelStr = sprintf(paramsDataset.kernelPath,paramsQuery.queryCorridor,trainingSet(i),paramsQuery.queryPass);
    kernelMatFileName = ['C2_db' convertnum(trainingSet(i)) '_q' convertnum(paramsQuery.queryPass)];
    kernelStr = ['data/'  kernelMatFileName];
    
    
    kernelStruct = load(kernelStr); % load kernel in the variable 'kernel'
    
    kernel = kernelStruct.kernel;

    
    scores          = kernel(queryFrame,:);
    [sortedScr, idx] = sort(scores,'descend');
    top(i,:)        = sortedScr(1:numTopMatches);
    topIdx(i,:)     = idx(1:numTopMatches);
    
end

bestMatchingFrames = [trainingSet; topIdx(:,1)']; % First row for db pass

end%     