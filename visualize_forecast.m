function [] = visualize_forecast(real_data_dates_plot,real_data,forecast,f_period,RMSE)
%   VISUALIZE_FORECAST
%   Rysuje wykres prognozy i wartoœci rzeczywistych danych prognozowanych
    name = sprintf('Prognoza z wyprzedzeniem %d próbek',f_period);
    tyt = sprintf('B³¹d prognozy RMSE = %f',RMSE);
    figure('Name',name);
    hold on;
    plot(real_data_dates_plot, real_data,'k--');
    plot(real_data_dates_plot, forecast(1:f_period,1),'r.');
    datetick('x', 29); 
    axis tight;
    title(tyt);
    sign = {'Dane rzeczywiste z okresu prognozowanego', 'Prognoza'};
    legend(sign,'Location','southwest');
    hold off;
end