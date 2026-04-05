function [psnr_val, ssim_val, mse_val, mae_val] = evaluate_metrics(original, processed)
    psnr_val = psnr(processed, original);
    ssim_val = ssim(processed, original);
    mse_val = immse(processed, original);
    mae_val = mean(abs(original(:) - processed(:)));
end
