function HR = ExpandRange(LG,HG,LG_factor,HG_factor)

%% Geoff's solution
HR = LG.*HG_factor/LG_factor + mod(HG,HG_factor/LG_factor);

HR = ((LG.*HG_factor/LG_factor + HG)./2 + (HG./HG_factor.*LG_factor + LG)./2);

tmp = uint16(zeros(size(HR)));
tmp(HR > 7*mean(mean(HR))) = HR(HR > 7*mean(mean(HR)));

HR = LG + tmp ;

if nargout == 0
    figure
    subplottight(1,3,1)
    imshow(LG.*15)
    title(['Low Gain'])
    
    subplottight(1,3,2)
    imshow(HG)
    title(['High Gain'])
    
    subplottight(1,3,3)
    imshow(HR)
    title(['Extended Range Image'])
    
    % Position, Size, and Color Figure Appropriately
    set(gcf,'Position',[10 50 1400 500]);
    return
    
end




end 