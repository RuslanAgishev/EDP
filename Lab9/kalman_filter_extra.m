function [Xpr,Ppr,Xfl,Pfl,K] = kalman_filter_extra(X0,P0,F,Q,H,R,z,m)
% H = [1 0];
% initialization
N = length(z);
Xpr = zeros(2,N);
Xpr(:,1) = X0;
Xfl = zeros(2,N-1);

Ppr = cell(1,N);
Ppr{1} = P0;
Pfl = cell(1,N);

K = zeros(2,N);
Xfl(:,1) = X0;
Pfl{1} = P0;
F = F^(m-1);
for i=2:N
    % prediction
    Xpr(:,i) = F*Xfl(:,i-1);
    Ppr{i} = F*Pfl{i-1}*(F') + Q;
    % filtration
    K(:,i) = Ppr{i}*(H')*inv(H*Ppr{i}*(H') + R);
    if isnan(z(i))
        Xfl(:,i) = Xpr(:,i);
        Pfl{i} = Ppr{i};
    else
        Xfl(:,i) = Xpr(:,i) + K(:,i)*(z(i)-H*Xpr(:,i));
        Pfl{i} = (eye(2)-K(:,i)*H)*Ppr{i};
    end
end

end