# MDAEP-SR: Learning Multi-Denoising Autoencoding Priors for Image Super-Resolution
The Code is created based on the method described in the following paper:   
Learning Multi-Denoising Autoencoding Priors for Image Super-Resolution, Journal of Visual Communication and Image Representation, 2018.  
Author: Y. Wang, H. Zhou, Q. Liu, Y. Wang.   
Date : 09/2018    
Version : 1.0   
The code and the algorithm are for non-comercial use only.   
Copyright 2018, Department of Electronic Information Engineering, Nanchang University.   
MDAEP - Single Image Super-Resolution  

Input:  
degraded: Observed blurry and noisy input RGB image in range of [0, 255].  
up_scale: Up scaling factor.  
params: Set of parameters.   
params.net: The DAE Network object from matCaffe.  

Optional parameters:  
map: Initial solution.  
params.sigma_net: The standard deviation of the network training noise. default: 11 & 25  
params.num_iter: Specifies number of iterations.  
params.gamma: Indicates the relative weight between the data term and the prior. default: 28.5  
params.mu: The momentum for SGD optimization. default: 0.9  
params.alpha the step length in SGD optimization. default: 0.1  

## The flowchart of MDAEP for SISR
 ![repeat-MDAEP](/figs/repeat-MDAEP.png)
