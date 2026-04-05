function visualization(I, noisy, denoised, recon, psnr_denoised, psnr_recon, ssim_denoised, ssim_recon)

figure('Name','图1 图像处理结果对比图','NumberTitle','off');
tiledlayout(2,2, 'Padding','compact', 'TileSpacing','compact');

nexttile;
imshow(I);
title('原始图像', 'FontSize', 14, 'FontWeight','bold');

nexttile;
imshow(noisy);
title('加噪图像', 'FontSize', 14, 'FontWeight','bold');

nexttile;
imshow(denoised);
title(sprintf('去噪图像\nPSNR = %.2f dB  SSIM = %.3f', psnr_denoised, ssim_denoised), ...
    'FontSize', 14, 'FontWeight','bold');

nexttile;
imshow(recon);
title(sprintf('重建图像\nPSNR = %.2f dB  SSIM = %.3f', psnr_recon, ssim_recon), ...
    'FontSize', 14, 'FontWeight','bold');

sgtitle('图1 图像处理结果对比图', 'FontSize', 16, 'FontWeight','bold');
