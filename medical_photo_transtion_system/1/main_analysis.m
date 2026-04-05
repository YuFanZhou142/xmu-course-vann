clc; clear; close all;

% 加载原图
I = im2double(imread('medical_photo_2.png'));

% ===== 1. 加噪图像 =====
noisy = I;
for c = 1:3
    noisy(:,:,c) = imnoise(I(:,:,c), 'salt & pepper', 0.1);
end

% ===== 2. 去噪处理 =====
denoised = morph_denoise(noisy);

% ===== 3. 小波压缩 =====
coeffs = cell(1,3); S = cell(1,3); recon = zeros(size(I));
for c = 1:3
    [~, coeffs{c}, S{c}] = wavelet_compress(denoised(:,:,c), 'haar', 2, 0.05);
    recon(:,:,c) = wavelet_reconstruct(coeffs{c}, S{c}, 'haar');
end

% ===== 4. 传输信道模拟（加高斯噪声） =====
transmitted = simulate_channel(recon, 'gaussian', 0.01);

% ===== 5. 接收端再去噪 =====
received = morph_denoise(transmitted);

% ===== 6. 指标对比 =====
[psnr_noisy, ssim_noisy] = evaluate_metrics(I, noisy);
[psnr_denoised, ssim_denoised] = evaluate_metrics(I, denoised);
[psnr_compressed, ssim_compressed] = evaluate_metrics(I, recon);
[psnr_transmit, ssim_transmit] = evaluate_metrics(I, transmitted);
[psnr_final, ssim_final] = evaluate_metrics(I, received);

% ===== 7. 可视化结果 =====
figure('Name','图像各阶段对比分析','NumberTitle','off');
subplot(2,3,1); imshow(I); title('原始图像');
subplot(2,3,2); imshow(noisy); title(sprintf('加噪图像\nPSNR=%.2f SSIM=%.2f',psnr_noisy,ssim_noisy));
subplot(2,3,3); imshow(denoised); title(sprintf('去噪图像\nPSNR=%.2f SSIM=%.2f',psnr_denoised,ssim_denoised));
subplot(2,3,4); imshow(recon); title(sprintf('压缩图像\nPSNR=%.2f SSIM=%.2f',psnr_compressed,ssim_compressed));
subplot(2,3,5); imshow(transmitted); title(sprintf('传输后图像\nPSNR=%.2f SSIM=%.2f',psnr_transmit,ssim_transmit));
subplot(2,3,6); imshow(received); title(sprintf('最终恢复图像\nPSNR=%.2f SSIM=%.2f',psnr_final,ssim_final));

visual_compare(I, received);