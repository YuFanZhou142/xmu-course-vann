function out = morph_denoise(I)
    if size(I,3) == 3
        out = zeros(size(I));
        for c = 1:3
            out(:,:,c) = process_channel(I(:,:,c));
        end
    else
        out = process_channel(I);
    end
end

function channel_out = process_channel(channel)
    se = strel('disk', 1);
    opened = imopen(channel, se);
    closed = imclose(opened, se);

    % Adaptive weighted filtering
    padI = padarray(closed, [1 1], 'symmetric');
    channel_out = closed;
    for i = 2:size(channel,1)+1
        for j = 2:size(channel,2)+1
            block = padI(i-1:i+1, j-1:j+1);
            mu = mean(block(:));
            sigma = std(block(:)) + 1e-3;
            w = exp(-(abs(block - mu) / sigma));
            w = w / sum(w(:));
            channel_out(i-1,j-1) = sum(sum(w .* block));
        end
    end
end
