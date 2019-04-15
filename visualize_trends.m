function [] = visualize_trends(data_dates_plot,data,PV_linear,PV_polynomial)
%   VISUALIZE_TRENDS
%   Funkcja do wizualizacji trendów
    figure('Name','Wizualizacja trendu liniowego i wielomianowego');
    hold on
    plot(data_dates_plot,data);
    plot(data_dates_plot,PV_linear, 'r');
    plot(data_dates_plot,PV_polynomial, 'y');
    datetick('x', 29);
    sign = {'Dane', 'Trend liniowy', 'Trend wielomianowy'};
    legend(sign,'Location','southeast');
    xlabel('Data');
    axis tight;
    hold off
end

