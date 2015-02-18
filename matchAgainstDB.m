function [bestMatchingFrame] = matchAgainstDB(encodedQuery)
% matchAgainstDB computes best matching frame based on chi 2 distance

% Authors: Jose Rivera-Rubio
%          jose.rivera@imperial.ac.uk
% Date: February, 2015

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

end