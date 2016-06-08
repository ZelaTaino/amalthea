%--------------------------------------------------------------------------
% Function:    getDatasets
% Description: Loads the coefficient datasets from saved .mat files.
% 
% Outputs
% 
% datasets    - A array of structs with fields
%                 'name'        :   name of the dataset
%                 'path'        : relative path from prefix to the dataset
%                 'dimensions'  : dimensions of the data
%                                   specified as [numCategories, numShapes/category]
%                 'labels'      : dimensions of the data
%                 'wName'       : the name of the wavelet
%                 'sampleSupp'  : the sample support of the wavelet
%                 'startLevel'  : the start level of the wavelet
%
% Usage: Used in hierarchical retrieval on the unit hypersphere.
%
% Authors(s):
%   Mark Moyou - markmmoyou@gmail.com
% Yixin Lin - yixin1996@gmail.com
%   Glizela Taino - glizelataino@gmail.com
%
% Date: Monday 6th June, 2016 (2:34pm)
%
% Affiliation: Florida Institute of Technology. Information
%              Characterization and Exploitation Laboratory.
%              http://research2.fit.edu/ice/
% -------------------------------------------------------------------------

function [datasets] = getDatasets()

prefix = '/Users/yixin/amalthea/data/';

% Dimensions are specified as [numCategories, numShapes/category]
datasets = {
  struct( ...
    'path', ...
      'Coefficients/Brown/db4r3/range_1_123/Brown_EV_PQA_1_2_3_3D_2r1__WT_db4_RL_3_p1.mat', ...
    'name', 'brown_123', ...
    'dimensions', [9 11]), ...
  struct( ...
    'path', ...
      'Coefficients/Brown/db4r3/range_1_125/Brown_PQA_1_2_5_r1_3D_WT_db4_RL_3_p1.mat', ...
    'name', 'brown_125', ...
    'dimensions', [9 11]), ...
  struct( ...
    'path', ...
      'Coefficients/MPEG7/db4r3/range_1_123/mpeg7Al_PQA_1_2_3_3D_2r1__WT_db4_RL_3.mat', ...
    'name', 'mpeg7_123', ...
    'dimensions', [70 20]), ...
  struct( ...
    'path', ...
      'Coefficients/MPEG7/db4r3/range_1_125/mpeg7Al_PQA_1_2_5_3D_2r1__WT_db4_RL_3.mat', ...
    'name', 'mpeg7_125', ...
    'dimensions', [70 20]), ...
  struct( ...
    'path', ...
      'Coefficients/SH11/db4r3/range_1_125/SHREC11_Or_PN_SSPts_GL_PQA_1_2_5_3D_2r1__WT_db4_RL_3.mat', ...
    'name', 'shrec11_125', ...
    'dimensions', [30 20]), ...
  struct( ...
    'path', ...
      'Coefficients/SH11/db4r3/range_1_125/SHREC11_Or_PN_SSPts_GL_PQA_1_2_5_3D_2r1__WT_db4_RL_3.mat', ...
    'name', 'shrec11_125', ...
    'dimensions', [30 20]), ...
};

for i = 1:length(datasets)
  load([prefix datasets{i}.path]);
  n = size(wdeCell,1); d = size(wdeCell{1,1}, 1); D = nan(n,d);
  for j = 1:n; D(j,:) = wdeCell{j,1}'; end;
  datasets{i} = setfield(datasets{i}, 'data', D);

  dimensions = datasets{i}.dimensions;
  numCategories = dimensions(1); numShapesPerCategory = dimensions(2);
  labels = kron(1:numCategories, ones(1,numShapesPerCategory))';
  datasets{i} = setfield(datasets{i}, 'labels', labels);

  datasets{i} = setfield(datasets{i}, 'sampleSupp', wdeCell{1,3}.sampleSupp);
  datasets{i} = setfield(datasets{i}, 'wName', wdeCell{1,3}.wName);
  datasets{i} = setfield(datasets{i}, 'startLevel', wdeCell{1,3}.startLevel);
end

end
