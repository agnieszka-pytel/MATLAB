function [] = visualize_series_and_diffs(dates_plot,index,diffs,stats_input,title)
%   VISUALIZE_SERIES_AND_DIFFS
%   Funkcja, która rysuje wykres szeregu czasowego oraz przyrostów
    figure('Name',title);
    subplot(2,1,1);
    plot(dates_plot,index); hold on; plot(dates_plot,ones(length(index),1)*stats_input{1,1});
    datetick('x', 29);
    sign = {'Wizualizacja szeregu','Œrednia'};
    legend(sign,'Location','southeast');
    xlabel('Data');
    ylabel('Wartoœæ zamkniêcia');
%     axis([733000 737100 3 5]);
    axis tight;
    subplot(2,1,2);
    plot(dates_plot(2:end),diffs,'r'); hold on; plot(dates_plot(2:end),ones(length(diffs),1)*stats_input{2,1});
    datetick('x', 29);
    sign = {'Wizualizacja przyrostów','Œrednia'};
    xlabel('Data');
    ylabel('Wartoœæ przyrostów');
    legend(sign,'Location','southeast');
%     axis([733000 737100 -0.2 0.2]);
    axis tight;
end

