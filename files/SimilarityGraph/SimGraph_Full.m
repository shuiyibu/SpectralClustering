function W = SimGraph_Full(M, sigma)
% SIMGRAPH_FULL Returns full similarity graph
%   Returns adjacency matrix for a full similarity graph where
%   a Gaussian similarity function with parameter sigma is
%   applied.
%
%   'M' - A d-by-n matrix containing n d-dimensional data points
%   'sigma' - Parameter for Gaussian similarity function
%
%   Author: Ingo Buerk
%   Year  : 2011/2012
%   Bachelor Thesis

% Compute distance matrix
W = squareform(pdist(M'));
% Squareform Reformat a distance matrix between upper triangular and square form.
% D = pdist(X) returns a vector D containing the Euclidean distances
%     between each pair of observations in the M-by-N data matrix X. Rows of
%     X correspond to observations, columns correspond to variables. D is a
%     1-by-(M*(M-1)/2) row vector, corresponding to the M*(M-1)/2 pairs of
%     observations in X.

% Apply Gaussian similarity function
W = simGaussian(W, sigma);

end