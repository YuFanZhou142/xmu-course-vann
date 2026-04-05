clc; clear; close all;

scriptDir = fileparts(mfilename('fullpath'));
addpath(scriptDir);
projectDir = fileparts(scriptDir);
imageDir = fullfile(projectDir, 'images');

% 原图
I = im2double(imread(fullfile(imageDir, 'medical_photo_2.png')));

% 加噪
noisy = I;
for c = 1:3
    noisy(:,:,c) = imnoise(I(:,:,c), 'salt & pepper', 0.1);
end

% 去噪
denoised = morph_denoise(noisy);

% 小波压缩
coeffs = cell(1,3); S = cell(1,3);
compressed = cell(1,3); recon = zeros(size(I));
for c = 1:3
    [compressed{c}, coeffs{c}, S{c}] = wavelet_compress(denoised(:,:,c), 'haar', 2, 0.05);
end

% 传输模拟：添加高斯噪声干扰
transmitted = zeros(size(I));
for c = 1:3
    temp = wavelet_reconstruct(coeffs{c}, S{c}, 'haar');
    transmitted(:,:,c) = simulate_channel(temp, 'gaussian', 0.01); % 可选: 'salt & pepper'
end

% 接收端去噪
received = morph_denoise(transmitted);

% 可视化结果对比
figure('Name','图像传输系统结果对比','NumberTitle','off');
subplot(2,2,1); imshow(I); title('原始图像');
subplot(2,2,2); imshow(noisy); title('加噪图像');
subplot(2,2,3); imshow(transmitted); title('传输后图像');
subplot(2,2,4); imshow(received); title('去噪恢复图像');
