function map = MDAEP_SR(degraded, up_scale, params, params2, map)
% Implements stochastic gradient descent (SGD) for maximum-a-posteriori for image super resolution described in:
% In the paper "Learning Multi-Denoising Autoencoding Priors for Image Super-Resolution".
%
% Input:
% degraded: Observed blurry and noisy input RGB image in range of [0, 255].
% sigma_d: Noise standard deviation.
% params: Set of parameters.
% up_scale: Up scaling factor.
% params.net: The DAE Network object from matCaffe.
% params.sigma_c The Network noise standard deviation.
%
% Optional parameters:
% map: Initial solution.
% params.sigma_net: The standard deviation of the network training noise. default: 25
% params.num_iter: Specifies number of iterations.
% params.gamma: Indicates the relative weight between the data term and the prior. default: 28.5
% params.mu: The momentum for SGD optimization. default: 0.9
% params.alpha the step length in SGD optimization. default: 0.1
%
% Outputs:
% map: Solution.

if ~any(strcmp('net',fieldnames(params)))
    error('Need a DAE as parameter!');
end

if ~any(strcmp('sigma_net',fieldnames(params)))
    params.sigma_net = 25;
end

if ~any(strcmp('num_iter',fieldnames(params)))
    params.num_iter = 300;
end

if ~any(strcmp('gamma',fieldnames(params)))
    params.gamma = 27.5;
end

if ~any(strcmp('sigma_c',fieldnames(params)))
    params.sigma_c = 25;
end

if ~any(strcmp('sigma_r',fieldnames(params)))
    params.sigma_r = sqrt(2)*25;
else
    params.sigma_r = max(params.sigma_r, params.sigma_c);
end

if ~any(strcmp('mu',fieldnames(params)))
    params.mu = .9;
end

if ~any(strcmp('alpha',fieldnames(params)))
    params.alpha = .1;
end

if ~any(strcmp('residualNet',fieldnames(params)))
    params.residualNet = 0;
end

disp(params)


if nargin < 6   %5
    map = imresize(degraded, up_scale, 'bicubic');
end

pad = up_scale;

step = zeros(size(map));


if any(strcmp('gt',fieldnames(params)))
    psnr = computePSNR(params.gt, map, pad);
    disp(['Initialized with PSNR: ' num2str(psnr)]);
end

for iter = 1:params.num_iter
    relative_weight = 1/sqrt(iter);

    if any(strcmp('gt',fieldnames(params)))
        disp(['Running iteration: ' num2str(iter)]);
        tic();
    end
    
    prior_err_sum = zeros(size(map));
    repeat_num = 3;
    
    for iiii = 1:repeat_num
        if size(map,3) == 3
            % compute prior gradient
            input = map(:,:,[3,2,1]); % Switch channels for caffe
        else
            map_all = repmat(map,[1,1,3]); % Switch channels for caffe
            input = map_all(:,:,[3,2,1]);
        end
    noise = randn(size(input)) * params.sigma_net;
    rec = params.net.forward({input+noise});
    prior_err = input - rec{1};
    rec = params.net.backward({-prior_err});
    prior_err = prior_err + rec{1};
    if size(map,3) == 3
        prior_err = prior_err(:,:,[3,2,1]);
    else
        prior_err = prior_err(:,:,[3,2,1]);
        prior_err = mean(prior_err,3);
    end       
    prior_err_sum = prior_err_sum + prior_err;
    end
    
    for iiii = 1:repeat_num
        if size(map,3) == 3
            % compute prior gradient
            input = map(:,:,[3,2,1]); % Switch channels for caffe
        else
            map_all = repmat(map,[1,1,3]); % Switch channels for caffe
            input = map_all(:,:,[3,2,1]);
        end
    noise = randn(size(input)) * params2.sigma_net;
    rec = params2.net.forward({input+noise});
    prior_err = input - rec{1};
    rec = params2.net.backward({-prior_err});
    prior_err = prior_err + rec{1};
    if size(map,3) == 3
        prior_err = prior_err(:,:,[3,2,1]);
    else
        prior_err = prior_err(:,:,[3,2,1]);
        prior_err = mean(prior_err,3);
    end
    prior_err_sum = prior_err_sum + prior_err;
    end
    
    prior_err = prior_err_sum/repeat_num/2;
    data_err = imresize(imresize(map, 1/up_scale, 'bicubic') - degraded, up_scale, 'bicubic');
    
    % sum the gradients
    err = relative_weight*prior_err + (1-relative_weight)*data_err;

    % update
    step = params.mu * step - params.alpha * err;
    map = map + step;
    map = min(255,max(0,map));
%     if mod(iter,40)==0, figure(200+iter);imshow([uint8(map)],[]);end

    if any(strcmp('gt',fieldnames(params)))
    	psnr = computePSNR(params.gt, map, pad);
        disp(['PSNR is: ' num2str(psnr) ', iteration finished in ' num2str(toc()) ' seconds']);
    end
end
