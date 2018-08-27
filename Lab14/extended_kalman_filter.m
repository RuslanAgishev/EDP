function [Xpr,Ppr,Xfl,Pfl,K] = extended_kalman_filter(X0,P0,F,Q,R,zx,zy,zV,zTheta)
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

Z = [zx; zy; zV; zTheta];


for i=2:N
    % prediction
    Xpr(:,i) = F*Xfl(:,i-1);
    Ppr{i} = F*Pfl{i-1}*(F') + Q;
    % filtration
    xpr = Xpr(1,i);
    Vxpr = Xpr(2,i);
    ypr = Xpr(3,i);
    Vypr = Xpr(4,i);
    [h1, h2] = cartesian2polar(Vxpr, Vypr);
    dH = dh_matrix(Vxpr,Vypr);
    H = [xpr; ypr; h1; h2];
    K{i} = Ppr{i}*(dH') / (dH*Ppr{i}*(dH') + R);
    Xfl(:,i) = Xpr(:,i) + K{i}*(Z(:,i)-H);
    Pfl{i} = (eye(4)-K{i}*dH)*Ppr{i};
end

end