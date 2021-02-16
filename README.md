# MDAEP-SR: Learning Multi-Denoising Autoencoding Priors for Image Super-Resolution
The Code is created based on the method described in the following paper:   
Learning Multi-Denoising Autoencoding Priors for Image Super-Resolution, Journal of Visual Communication and Image Representation, 2018.  
Author: Y. Wang, Q. Liu, H. Zhou, Y. Wang.   
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
 

## Other Related Projects
  * Multi-Channel and Multi-Model-Based Autoencoding Prior for Grayscale Image Restoration  
[<font size=5>**[Paper]**</font>](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=8782831)   [<font size=5>**[Code]**</font>](https://github.com/yqx7150/MEDAEP)   [<font size=5>**[Slide]**</font>](https://github.com/yqx7150/EDAEPRec/tree/master/Slide)

  * Highly undersampled magnetic resonance imaging reconstruction using autoencoding priors  
[<font size=5>**[Paper]**</font>](https://onlinelibrary.wiley.com/doi/abs/10.1002/mrm.27921)   [<font size=5>**[Code]**</font>](https://github.com/yqx7150/EDAEPRec)   [<font size=5>**[Slide]**</font>](https://github.com/yqx7150/EDAEPRec/tree/master/Slide)

  * High-dimensional Embedding Network Derived Prior for Compressive Sensing MRI Reconstruction  
 [<font size=5>**[Paper]**</font>](https://www.sciencedirect.com/science/article/abs/pii/S1361841520300815?via%3Dihub)   [<font size=5>**[Code]**</font>](https://github.com/yqx7150/EDMSPRec)
 
  * Denoising Auto-encoding Priors in Undecimated Wavelet Domain for MR Image Reconstruction  
 [<font size=5>**[Paper]**</font>](https://www.sciencedirect.com/science/article/pii/S0925231221000990) [<font size=5>**[Paper]**</font>](https://arxiv.org/ftp/arxiv/papers/1909/1909.01108.pdf)   [<font size=5>**[Code]**</font>](https://github.com/yqx7150/WDAEPRec)

  * Learning Priors in High-frequency Domain for Inverse Imaging Reconstruction  
[<font size=5>**[Paper]**</font>](https://arxiv.org/ftp/arxiv/papers/1910/1910.11148.pdf)   [<font size=5>**[Code]**</font>](https://github.com/yqx7150/HFDAEP)

  * REDAEP: Robust and Enhanced Denoising Autoencoding Prior for Sparse-View CT Reconstruction  
[<font size=5>**[Paper]**</font>](https://ieeexplore.ieee.org/document/9076295)   [<font size=5>**[Code]**</font>](https://github.com/yqx7150/REDAEP)
