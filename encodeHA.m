function [encodedQuery] = encodeHA(queryDescriptors)
% encodeHA Hard Assignment vector quantization

% Authors: Jose Rivera-Rubio
%          jose.rivera@imperial.ac.uk
% Date: February, 2015


dictStruct = load('dictionary');
VWords = dictStruct.VWords;
sizeDescriptors = size(VWords,1);
numWords = size(VWords,2);

% Dictionary normalisation and single precision

VWords = single(VWords);

VWords = VWords./repmat(sqrt(sum(VWords.^2,1))+eps,[sizeDescriptors,1]);

% Allocate memory for the encoded pass. Size will be numFrames x numWords

encodedQuery = zeros(numWords,'single');

% Normalise current frame descriptors
queryDescriptors = single(queryDescriptors') ./ ...
    repmat(sqrt(sum(queryDescriptors'.^2,1))+eps,[sizeDescriptors,1]);

% Project descriptor on dictionary. The maximum projection is the
% closest word from the vocabulary.

projected_descriptor = queryDescriptors' * VWords;

[~,words_id] = max(projected_descriptor,[],2);

HoVW = hist(words_id,1:numWords);

encodedQuery = HoVW;

end
