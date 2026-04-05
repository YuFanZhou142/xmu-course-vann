function [compressed, coeffs, S, compressed_size] = wavelet_compress(I, wname, level, thresh)
    [C,S] = wavedec2(I, level, wname);
    C_thresh = C .* (abs(C) > thresh);  % Hard thresholding
    compressed = C_thresh;
    coeffs = C_thresh;
    compressed_size = nnz(C_thresh);  % 非零系数个数视作压缩大小
end
