# XMU System Modeling and Simulation Course Project

This repository contains a MATLAB course project for **System Modeling and Simulation**. The project builds a small experimental pipeline for **medical image denoising, wavelet-based compression, transmission distortion simulation, and post-transmission restoration**.

The main idea is to study how a medical image changes when it goes through:

1. artificial acquisition/transmission noise,
2. adaptive denoising,
3. wavelet compression,
4. noisy channel transmission,
5. receiver-side restoration,
6. quantitative and visual evaluation.

This repository is an **academic assignment** rather than a production-ready medical imaging system. It is best understood as a teaching/demo project for image processing and communication-system simulation in MATLAB.

## Project Objective

Medical images often need to be stored, transmitted, and reconstructed under quality constraints. In remote diagnosis or network-based image transfer, two problems become especially important:

- image noise can damage clinically important structures,
- large image size increases storage and transmission cost.

To address this, the project combines:

- **morphological adaptive denoising** to reduce impulse noise while preserving structure,
- **wavelet-domain coefficient thresholding** to compress the image,
- **channel distortion simulation** to model transmission noise,
- **image quality metrics and visualization** to analyze the result.

## Processing Pipeline

The core pipeline implemented in the repository is:

```text
Original image
  -> Salt-and-pepper noise injection
  -> Morphological adaptive denoising
  -> Haar wavelet decomposition and thresholding
  -> Wavelet reconstruction
  -> Channel noise simulation
  -> Receiver-side denoising
  -> Metric evaluation and visualization
```

In the main experiment script, the image is processed stage by stage and compared against the original image using both numerical metrics and visual plots.

## Main Features

- Medical image transmission simulation in MATLAB
- Salt-and-pepper noise injection for degradation modeling
- Morphological opening/closing plus adaptive weighted filtering
- Haar wavelet compression with hard thresholding
- Gaussian or salt-and-pepper channel distortion simulation
- Receiver-side restoration
- PSNR, SSIM, MSE, and MAE quality evaluation
- Visual comparison through histograms, heatmaps, edge maps, and intensity plots
- A simple GUI demo for interactive display

## Repository Structure

The repository has been reorganized so that source code, images, and saved data are separated instead of being mixed in one folder.

| Path | Description |
| --- | --- |
| `README.md` | Project overview |
| `vann系统建模与仿真设计.docx` | Course report describing background, design, and analysis |
| `medical_photo_transtion_system/code/` | MATLAB source code |
| `medical_photo_transtion_system/images/` | Input and demo image assets |
| `medical_photo_transtion_system/data/` | Saved data assets |
| `medical_photo_transtion_system/code/main_system.m` | Quick demonstration script |
| `medical_photo_transtion_system/code/main_analysis.m` | Full analysis pipeline with metrics and visualizations |
| `medical_photo_transtion_system/code/morph_denoise.m` | Core adaptive denoising algorithm |
| `medical_photo_transtion_system/code/wavelet_compress.m` | Wavelet decomposition and coefficient thresholding |
| `medical_photo_transtion_system/code/wavelet_reconstruct.m` | Wavelet reconstruction |
| `medical_photo_transtion_system/code/simulate_channel.m` | Channel noise/distortion simulation |
| `medical_photo_transtion_system/code/evaluate_metrics.m` | PSNR, SSIM, MSE, MAE evaluation |
| `medical_photo_transtion_system/code/visual_compare.m` | Histogram, heatmap, edge, and intensity visualization |
| `medical_photo_transtion_system/code/visualization.m` | Additional comparison figure helper |
| `medical_photo_transtion_system/code/evaluate_compression_ratio.m` | Approximate compression ratio estimation |
| `medical_photo_transtion_system/code/morphwavelet_gui.m` | Simple GUI demo |
| `medical_photo_transtion_system/images/medical_photo.png` | Sample image asset |
| `medical_photo_transtion_system/images/medical_photo_2.png` | Main medical image used by the scripts |
| `medical_photo_transtion_system/images/Xiamen_University.jpg` | Image used by the GUI demo |
| `medical_photo_transtion_system/data/wavelet_compressed.mat` | Saved wavelet-related data asset |

## Core Scripts

### `main_system.m`

This is the simpler end-to-end demo script. It:

- loads the original image,
- adds salt-and-pepper noise,
- denoises the noisy image,
- applies wavelet compression and reconstruction,
- simulates transmission noise,
- denoises again at the receiver,
- shows a 4-panel figure for quick comparison.

This script is useful when you want a short demonstration of the overall idea.

### `main_analysis.m`

This is the main experimental script in the repository. It performs the full pipeline and then evaluates the image quality at multiple stages:

- original image,
- noisy image,
- denoised image,
- compressed/reconstructed image,
- transmitted image,
- final restored image.

It computes:

- **PSNR**
- **SSIM**
- **MSE**
- **MAE**

and produces multiple visual outputs to support the analysis.

### `morphwavelet_gui.m`

This file provides a simple GUI interface that lets the user click buttons and display:

- original image,
- noisy image,
- denoised image,
- compressed image.

Note: the GUI currently uses `images/Xiamen_University.jpg` as its sample input, while the main analysis scripts use `images/medical_photo_2.png`.

## Methodology

### 1. Noise Injection

The experiment first adds **salt-and-pepper noise** to the RGB channels of the input image. This simulates acquisition errors or transmission disturbances that may occur in practical scenarios.

In the current scripts, the noise density is set to `0.1`.

### 2. Morphological Adaptive Denoising

The denoising algorithm is implemented in `morph_denoise.m`. It works in two stages:

1. **Morphological filtering**
   - opening with a disk structuring element,
   - closing with the same structuring element.

2. **Adaptive weighted local smoothing**
   - a `3x3` neighborhood is extracted around each pixel,
   - local mean and standard deviation are computed,
   - weights are assigned based on similarity to the neighborhood statistics,
   - the output pixel is computed as a weighted sum.

This design tries to balance:

- noise suppression,
- edge preservation,
- structural consistency.

### 3. Wavelet Compression

Wavelet compression is implemented in `wavelet_compress.m`. The project uses:

- **Haar wavelet**
- **2 decomposition levels**
- **hard thresholding**

The process is:

1. decompose the image using `wavedec2`,
2. suppress small-magnitude coefficients,
3. keep the remaining coefficients as the compressed representation,
4. reconstruct the image using `waverec2`.

This is an educational compression model based on wavelet sparsity. It is **not** a full industrial codec such as JPEG2000 with entropy coding and bitstream packaging.

### 4. Channel Simulation

`simulate_channel.m` models transmission disturbances after reconstruction. Supported channel types are:

- `none`
- `gaussian`
- `salt & pepper`

The main analysis uses **Gaussian noise** with level `0.01` to simulate transmission degradation.

### 5. Receiver-Side Restoration

After channel distortion is added, the received image is denoised again using the same adaptive denoising function. This models a receiver-side post-processing step to recover as much structural information as possible.

### 6. Evaluation and Visualization

The project evaluates image quality with:

- **PSNR**: peak signal-to-noise ratio
- **SSIM**: structural similarity index
- **MSE**: mean squared error
- **MAE**: mean absolute error

The project also visualizes the result using:

- stage-by-stage image comparison,
- RGB histogram comparison,
- difference heatmap,
- Sobel edge structure comparison,
- RGB channel intensity distribution plots.

## Requirements

To run the project, you need:

- MATLAB
- Image Processing Toolbox
- Wavelet Toolbox

The project uses functions such as:

- `imread`
- `imnoise`
- `strel`
- `imopen`
- `imclose`
- `psnr`
- `ssim`
- `wavedec2`
- `waverec2`
- `uifigure`

## How to Run

Open MATLAB and change the working directory to:

```matlab
medical_photo_transtion_system/code
```

Then run one of the following scripts:

### Quick demo

```matlab
main_system
```

### Full analysis

```matlab
main_analysis
```

### GUI demo

```matlab
morphwavelet_gui
```

Important:

- The project now separates source code and image assets into different folders.
- The scripts resolve image paths from their own location, so the repository structure is cleaner and less fragile than before.
- The main experimental scripts use `images/medical_photo_2.png`.
- The GUI uses `images/Xiamen_University.jpg`.

## Expected Outputs

### `main_system.m`

This script displays a 4-panel figure:

- original image,
- noisy image,
- transmitted image,
- restored image.

### `main_analysis.m`

This script displays:

- a 6-panel figure covering all processing stages,
- quality metrics for each stage,
- RGB histogram comparison,
- difference heatmap,
- edge structure comparison,
- channel intensity distribution plots.

## Reported Example Results

According to the accompanying course report, one representative experiment produced approximately the following results:

| Stage | PSNR (dB) | SSIM |
| --- | ---: | ---: |
| Noisy image | 14.68 | 0.40 |
| Denoised image | 30.50 | 0.99 |
| Compressed image | 30.00 | 0.98 |
| Transmitted image | 20.17 | 0.56 |
| Final restored image | 24.44 | 0.92 |

These values are useful as a reference for the intended behavior of the pipeline, but actual results may vary with:

- MATLAB version,
- toolbox version,
- image choice,
- parameter changes.

## Project Strengths

- Covers the full chain from degradation to restoration
- Combines image processing and communication-system simulation ideas
- Includes both quantitative metrics and visual analysis
- Easy to understand and extend for coursework or demonstrations
- Organized around clear MATLAB function modules

## Limitations

- This is a **single-project academic prototype**, not a clinical tool
- The compression stage is coefficient thresholding, not a full coding standard
- Most parameters are hard-coded in the scripts
- The compression ratio estimation is approximate
- The experiments are not automated for large datasets
- The GUI and main experiment use different sample images
- There is no training, optimization, or model selection pipeline

## Possible Improvements

Future work suggested by the project itself includes:

- trying more advanced wavelet families such as Daubechies, Symlets, or Coiflets,
- comparing against stronger denoising methods,
- adding deep learning based denoisers,
- improving the GUI and user interaction,
- running batch experiments over multiple medical images,
- recording compression ratio and reconstruction quality more rigorously,
- turning the scripts into a more reproducible experimental framework.

## Academic Note

This repository appears to be a course assignment submission for learning and demonstration purposes. The original Chinese report is included in the repository for full background and analysis.

If you use this project as a reference, it is better to:

- understand the processing pipeline,
- reproduce the experiment yourself,
- improve the algorithms and evaluation,
- avoid copying it directly as a final submission.
