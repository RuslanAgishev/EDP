function range = angle2ind(angle,i,fi)
t=1;
for j=1:length(fi)
   if fi(j)>(fi(i)-angle) && fi(j)<(fi(i)+angle)
       range(t) = j;
       t=t+1;
   end
end
end