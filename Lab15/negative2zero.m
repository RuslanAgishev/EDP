function newI = negative2zero(I)
N = length(I);
newI = I;
for j=1:N
    if I(j)<0
        newI(j) = 0;
    end
end
end