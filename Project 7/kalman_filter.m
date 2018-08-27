function [Xpr,Ppr,Xfl,Pfl,K,V] = kalman_filter(X0,P0,F,H,R,Q,Z, sigmaN, scale,v)
% initialization
N = length(Z);
Xpr = nan(4,N);
Xpr(:,1) = X0;
Xfl = nan(4,N);

Ppr = cell(1,N);
Ppr{1} = P0;
Pfl = cell(1,N);

K = cell(1,N);
K{1} = zeros(4,2);
Xfl(:,1) = X0;
Pfl{1} = P0;

V = nan(2,N);
count = 0;
% Q = zeros(size(P0));
for i=2:N
    % prediction
    Xpr(:,i) = F * Xfl(:,i-1);
    Ppr{i} = F * Pfl{i-1} * (F') + Q;
    % filtration
    K{i} = Ppr{i} * (H') / (H * Ppr{i} * (H') + R);
    Xfl(:,i) = Xpr(:,i) + K{i}*(Z(:,i) - H*Xpr(:,i));
    V(:,i) = Z(:,i)-H*Xpr(:,i);
    % Pfl{i} = (eye(4)-K{i}*H)*Ppr{i};
    if nargin==8
        Pfl{i} = (eye(4)-K{i}*H)*Ppr{i};
    elseif nargin==10
        cndt = abs(v(:,i))>scale*sigmaN;
        if cndt(1)+cndt(2)>0 && count==0
            Pfl{i} = P0;
            count = 1;
        else
            Pfl{i} = (eye(4)-K{i}*H)*Ppr{i};
        end
    end
end

end

