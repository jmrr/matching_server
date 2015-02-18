function relativePosition = matchingServer(imgFilename) %#codegen
% MATCHING SERVER MATLAB SCRIPT
% Requires VLFEAT installed and visible from MATLAB prompt: http://www.vlfeat.org
%
% Author: Jose Rivera-Rubio
% 	  Feb 2015

%%  DSIFT

step = 3; % Step between descriptor centres, or grid step size.

smoothingSigma = 1.2; % smoothingSigma = (binSize/magnif)^2 - .25; where
% magnif is the relationship between keypoint scale
% and bin size. By default, magnif is 3.00

binSize = 3;

I = single(rgb2gray(imread(imgFilename)));

Is = vl_imsmooth(I,smoothingSigma);

[~,descriptors] = vl_dsift(Is,'step',step,'size',binSize,'FloatDescriptors');

queryDescriptors = descriptors ./ repmat(sqrt(sum(descriptors.^2,1))+eps...
    ,[size(descriptors,1),1]);

%% HA

dictStruct = load('dictionary');
VWords = dictStruct.VWords;
sizeDescriptors = size(VWords,1);
numWords = size(VWords,2);

% Dictionary normalisation and single precision

VWords = single(VWords);

VWords = VWords./repmat(sqrt(sum(VWords.^2,1))+eps,[sizeDescriptors,1]);

% Project descriptor on dictionary. The maximum projection is the
% closest word from the vocabulary.

projected_descriptor = queryDescriptors' * VWords;

[~,words_id] = max(projected_descriptor,[],2);

HoVW = hist(words_id,1:numWords);

encodedQuery = HoVW;

%% MATCHING

dbStruct = load('encodedP5');
db = dbStruct.HoVW;

% Compute chi2 distance (chi2 distance kernel);

% repEncodedQuery = repmat(bestMatchingFrame,size(db,1),1);
stackQ = encodedQuery./sqrt(sum(encodedQuery.^2));
stackQ = vl_homkermap(stackQ',1,'kchi2');

stackDb = db./repmat(sqrt(sum(db.^2,2))+eps,[1,size(db,2)]);
            
stackDb = vl_homkermap(stackDb',1,'kchi2');

kernel = stackQ'*stackDb;

[~, bestMatchingFrame] = max(kernel);

%% POSITION RETRIEVAL


gt = csvread('ground_truth_C2_P5.csv',1,1);

relativePosition = gt(bestMatchingFrame)/gt(end);

%% WRITE OUTPUT

fid = fopen('out','a');
fprintf(fid,'%f\n',relativePosition);
fclose(fid);

end
