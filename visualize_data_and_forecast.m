function [] = visualize_data_and_forecast(data_dates_plot,data,real_data_dates_plot,real_data,forecast,f_period,RMSE)
%   VISUALIZE_DATA_AND_FORECAST
%   Rysuje wykres analizowanych danych wraz z prognoz¹ oraz wartoœciami
%   rzeczywistymi danych prognozowanych
    name = sprintf('Prognoza z wyprzedzeniem %d próbek',f_period);
    tyt = sprintf('B³¹d prognozy RMSE = %f',RMSE);
    figure('Name',name);
    hold on; 
    plot(data_dates_plot, data); 
    plot(real_data_dates_plot, real_data,'k--');
    plot(real_data_dates_plot, forecast(1:f_period,1),'r.');
    datetick('x', 29); 
    axis tight;
    title(tyt);
    sign = {'Dane', 'Dane rzeczywiste z okresu prognozowanego', 'Prognoza'};
    legend(sign,'Location','southeast');
    hold off;
end

