function distorted = simulate_channel(image, channel_type, noise_level)
% 模拟图像传输过程（添加失真/噪声）
% channel_type: 'none' | 'gaussian' | 'salt & pepper'
% noise_level: 控制强度，例如 0.01, 0.05 等

if nargin < 2
    channel_type = 'none';
end
if nargin < 3
    noise_level = 0.01;
end

distorted = image;

switch lower(channel_type)
    case 'none'
        % 无干扰传输
    case 'gaussian'
        for c = 1:size(image, 3)
            distorted(:,:,c) = imnoise(image(:,:,c), 'gaussian', 0, noise_level);
        end
    case 'salt & pepper'
        for c = 1:size(image, 3)
            distorted(:,:,c) = imnoise(image(:,:,c), 'salt & pepper', noise_level);
        end
    otherwise
        warning('未知信道类型，使用无失真传输');
end
end
