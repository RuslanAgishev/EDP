function [Xsm, Psm] = smoothing_back(Xfl, Pfl, Ppr, F)
N = size(Xfl,2);
A = cell(1,N);
Psm = cell(1,N);
Xsm = zeros(2,N);
Xsm(:,N) = Xfl(:,N);
Psm{N} = Pfl{N};
for i=(N-1):-1:1
    A{i} = Pfl{i} * F' * inv(Ppr{i+1});
    Xsm(:,i) = Xfl(:,i) + A{i} * (Xsm(:,i+1) - F*Xfl(:,i));
    Psm{i} = Pfl{i} + A{i} * (Psm{i+1} - Ppr{i+1}) * A{i}';
end
end