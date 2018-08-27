function [Xpr,Ppr,Xfl,Pfl,K] = kalman_filter(X0,P0,F,Q,H,R,zx,zy)
% initialization
N = length(zx);
Xpr = nan(4,N);
Xpr(:,1) = X0;
Xfl = nan(4,N);

Ppr = cell(1,N);
Ppr{1} = P0;
Pfl = cell(1,N);

K = cell(1,N);
Xfl(:,1) = X0;
Pfl{1} = P0;

Z = [zx; zy];
for i=2:N
    % prediction
    Xpr(:,i) = F*Xfl(:,i-1);
    Ppr{i} = F*Pfl{i-1}*(F') + Q;
    % filtration
    K{i} = Ppr{i}*(H') / (H*Ppr{i}*(H') + R);
    Xfl(:,i) = Xpr(:,i) + K{i}*(Z(:,i)-H*Xpr(:,i));
    Pfl{i} = (eye(4)-K{i}*H)*Ppr{i};
end

end