% Thanks!  http://www.briandalessandro.com/blog/how-to-make-a-borderless-subplot-of-images-in-matlab/

function subplottight(n,m,i)
    [c,r] = ind2sub([m n], i);
    subplot('Position', [(c-1)/m + 0.005*(m+i)/m, 1-(r)/(n), 1/(m*1.05), 1/n])
end