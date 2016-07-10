% -------------------------------------------------------------------------
% Script: linassgn_demo
% Author: 	Mark Moyou (mmoyou@my.fit.edu)
% 			Yixin Lin (yixin1996@gmail.com)
% 			Glizela Taino (glizentaino@gmail.com)
% Affiliation: Florida Institute of Technology. Information
%              Characterization and Exploitation Laboratory.
%              http://research2.fit.edu/ice/
% Description: This shows the effect that varying
%               lambda has on linear assignment.
% Usage: Used in hierarchical clustering on the unit hypersphere.
% -------------------------------------------------------------------------

DISP = 1; % Display results boolean
% lambdas = [1e-2 3e-2 5e-2 1e-1 1];
lambdas = [1 1e-1 5e-2 1e-2 1e-3];
viewangles = [180 85];
curr_colormap = jet;
plot_settings = @(curr) surf(curr);

% Circle square demo
% m = 36; n = 36;
% circle = imread('images/circle.jpg');
% circle = double(rgb2gray(imresize(circle, [m n]))) ./ 255.0;
% square = imread('images/square.jpg');
% square = double(rgb2gray(imresize(square, [m n]))) ./ 255.0;

% distMatrix = construct_dist_matrix([m n]);

% linassgn_warp(circle, square, distMatrix, lambdas, DISP);

% MPEG7 datasets

% prefix = '/Users/yixin/amalthea/data/';
% load([prefix 'Coefficients/MPEG7_raw/apple.mat']);
% load([prefix 'Coefficients/MPEG7_raw/bird.mat']);
datasets = getDatasets({'mpeg_7_haar_singleres', 'mpeg_7_haar_multires', 'mpeg_7_sym4_singleres', 'mpeg_7_sym4_multires'}, '~/amalthea/data/new_coeffs/');

m = 34; n = 34;
distMatrix = construct_dist_matrix([m n]);

a = 21; b = 421;

imgs = { ...
  datasets{2}.data(a,:)',
  datasets{2}.data(b,:)',
  % apple01, ...
  % apple02, ...
  % bird01, ...
};

for i = 1:length(imgs)
  curr = imgs{i};
  currMax = max(curr);
  imgs{i} = reshape(curr, [m n]) / currMax;
  imgs{i} = flipud(fliplr(imgs{i}));
end

for i = 1:length(imgs)
  for j = i+1:length(imgs)
    source = imgs{i}; target = imgs{j};
    warped_imgs = linassgn_warp(source, target, distMatrix, lambdas);

    if DISP
      for k = 1:length(lambdas)
        subplot(2, length(lambdas), k);
        curr = warped_imgs{k};
        curr = reshape(curr, [m n]);
        surf(curr); shading interp; colormap(curr_colormap); grid off; axis off; view(viewangles);
        sphdist = sphere_dist(curr(:)/norm(curr(:)), target(:)/norm(target(:)));
        title(['Lambda = ' num2str(lambdas(k))]);
        xlabel(['sphere dist=' num2str(sphdist)]);
      end
      subplot(2, k, k + 1);
      surf(source); shading interp; colormap(curr_colormap); grid off; axis off; view(viewangles);
      view(viewangles);
      title('Source');
      subplot(2, k, k + 2);
      surf(target); shading interp; colormap(curr_colormap); grid off; axis off; view(viewangles);
      title('Target');
      sphdist = sphere_dist(curr(:)/norm(curr(:)), target(:)/norm(target(:)));
      xlabel(['sphere dist=' num2str(sphdist)]);
    end

  end
end

