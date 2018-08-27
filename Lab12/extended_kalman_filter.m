function [Xpr,Ppr,Xfl,Pfl,K] = extended_kalman_filter(P0,F,Q,R,b,D,bm,Dm)
% initialization
X0 = zeros(4,1);
X0(1) = Dm(1)*sin(bm(1));
X0(3) = Dm(1)*cos(bm(1));
N = length(b);
Xpr = nan(4,N);
Xpr(:,1) = X0;
Xfl = nan(4,N);

Ppr = cell(1,N);
Ppr{1} = P0;
Pfl = cell(1,N);

K = cell(1,N);
Xfl(:,1) = X0;
Pfl{1} = P0;

Z = [Dm; bm];

for i=2:N
    % prediction
    Xpr(:,i) = F*Xfl(:,i-1);
    Ppr{i} = F*Pfl{i-1}*(F') + Q;
    % filtration
    xpr = Xpr(1,i);
    ypr = Xpr(3,i);
    dH = dh_matrix(xpr,ypr);
    [h1, h2] = cartesian2polar(xpr, ypr);
    H = [h1; h2];
    K{i} = Ppr{i}*(dH') / (dH*Ppr{i}*(dH') + R);
    Xfl(:,i) = Xpr(:,i) + K{i}*(Z(:,i)-H);
    Pfl{i} = (eye(4)-K{i}*dH)*Ppr{i};
end

end