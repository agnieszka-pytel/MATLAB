function [] = series_and_data_boxplots(index,diffs,tyt)
%   SERIES_AND_DATA_BOXPLOTS
%   Funkcja rysuj¹ca wykresy pudelkowe dla szeregu i przyrostow
    figure('Name',tyt);
    subplot(1,2,1);
    boxplot(index);
    title('Wykres pude³kowy dla wartoœci zamkniêcia');
    subplot(1,2,2);
    boxplot(diffs);
    title('Wykres pude³kowy dla przyrostów');
end

