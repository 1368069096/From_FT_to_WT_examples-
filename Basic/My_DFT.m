function Y = My_DFT(y)
    % DFT: Find the DFT of the discrete number list y
    % input: 
    % y: the discrete number list y
    % output
    % Y: the DFT of discrete number list y
    
    % ����
    N = length(y); 
    omega = exp(-1j*2*pi/N); 
    row = 0:N-1; 
    col = row'; 
    F = omega.^(col*row);
    Y = F*y';
    % ת�û��������ʹ��reshape
    Y = reshape(Y,1,N);
    
    % ���巨
%     N = length(y);
%     num_list = 0:N-1;
%     Y = zeros(1,N);
%     
%     sum(omega.^(0:7).*y)
%     
%     for index = 1:1
%         calculate the coefficient
%         Y(index+1) = sum(y.*exp(-1j*2*pi*index/N*num_list))
%     end
    
end
