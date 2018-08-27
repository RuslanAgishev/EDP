function jc = intenscenter(I)
N = length(I);
if iscolumn(I)
    I = I';
end
jc = ceil( sum((1:N).*I) / sum(I) )-1;
end