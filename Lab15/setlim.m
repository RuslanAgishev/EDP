function newimg =setlim(img, limits)
newimg = img;
R = size(newimg,1);
C = size(newimg,2);
for r=1:R
    for c=1:C
        if (img(r,c)>limits(2))
            newimg(r,c) = NaN;
        elseif (img(r,c)<limits(1))
            newimg(r,c) = NaN;
        end
    end
end
end