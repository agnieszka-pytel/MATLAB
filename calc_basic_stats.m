function [stats] = calc_basic_stats(index,diffs)
%   CALC_BASIC_STATS
%   Funkcja licz¹ca podstawowe statystyki takie jak œrednia, wariancja,
%   odchylenie standardowe, skoœnoœæ.
    means = [mean(index); mean(diffs)];
    medians = [median(index); median(diffs)];
    vars = [var(index); var(diffs)];
    stds = [std(index); std(diffs)];
    skews = [skewness(index); skewness(diffs)];
    stats = table(means, medians, vars, stds, skews, 'RowNames',{'Index','Diffs'});
    disp(stats);
end

