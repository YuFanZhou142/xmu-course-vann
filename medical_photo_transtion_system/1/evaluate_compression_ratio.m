function ratio = evaluate_compression_ratio(original, coeffs)
    % original: HxWx3 double image
    % coeffs: cell array of wavelet coefficients per channel

    original_bits = numel(original) * 8; % assuming 8 bits per channel
    compressed_bits = 0;

    for c = 1:3
        nonzero = nnz(coeffs{c});  % only count non-zero coefficients
        compressed_bits = compressed_bits + nonzero * 8;  % assume 8 bits per non-zero
    end

    ratio = original_bits / compressed_bits;
end
