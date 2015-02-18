function [normalisedDescriptors] = dsift(imgFilename, varargin)
% DSIFT computes Dense-SIFT descriptor using VLFEAT API

% Authors: Jose Rivera-Rubio
%          jose.rivera@imperial.ac.uk
% Date: February, 2015


% SIFT descriptor parameters

if nargin < 4 % Default case
    step = 3; % Step between descriptor centres, or grid step size.
else 
    step = varargin{1};
end

smoothingSigma = 1.2; % smoothingSigma = (binSize/magnif)^2 - .25; where
% magnif is the relationship between keypoint scale
% and bin size. By default, magnif is 3.00

binSize = 3;


I = single(rgb2gray(imread(imgFilename)));

Is = vl_imsmooth(I,smoothingSigma);

[~,descriptors] = vl_dsift(Is,'step',step,'size',binSize,'FloatDescriptors');

descriptors = descriptors';

normalisedDescriptors = descriptors ./ repmat(sqrt(sum(descriptors.^2,2))+eps...
    ,[1,size(descriptors,2)]);

end