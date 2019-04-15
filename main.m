clear all; close all, clear global;
% %Pakiety Octave
%pkg load optim; 
%pkg load financial;
%pkg load statistics;

% %Wczytanie danych
fileID = fopen('eurpln_d.csv');
input = textscan(fileID,'%s %f %f %f %f', 'Delimiter', ',', 'HeaderLines', 1);
fclose(fileID);

% %Formatowanie
dates = datestr(input{1}, 29);
dates_plot = datenum(dates); 
index = input{5};
index_yearly = [year(dates) index];

% %Obliczenie przyrostow
diffs = diff(index);

%Podstawowe statystyki
% stats_input = calc_basic_stats(index,diffs);
% 
% %Wizualizacja szeregu czasowego i jego przyrostow
% tyt = 'Wizualizacja szeregu czasowego i przyrostów';
% visualize_series_and_diffs(dates_plot,index,diffs,stats_input,tyt);
% 
% %Wykresy pudelkowe dla szeregu i przyrostow
% tyt = 'Wykresy pudelkowe dla szeregu i przyrostow';
% series_and_data_boxplots(index,diffs,tyt);
% 
% %Analiza danych w ujeciu rocznym
% [bp,mean_yearly,median_yearly,var_yearly,std_yearly,skew_yearly] = yearly_analysis(index_yearly);
% 
% %Wybór przedzia³u do analizy (2011-2016)
data = index(1016:2562,:);
data_diffs = diff(data);
data_dates = dates(1016:2562,:);
data_dates_plot = datenum(data_dates);

% %Podstawowe statystyki analizowanego zbioru
% stats_data = calc_basic_stats(data, data_diffs);
% 
% %Wizualizacja szeregu czasowego i jego przyrostow
% tyt = 'Wizualizacja szeregu czasowego wybranego do analizy i jego przyrostow';
% visualize_series_and_diffs(data_dates_plot,data,data_diffs,stats_data,tyt);
% 
% % %Wykresy pudelkowe dla srednich i przyrostow 
% tyt = 'Wykresy pudelkowe dla szeregu wybranego do analizy i przyrostow';
% series_and_data_boxplots(data,data_diffs,tyt);
% 
% % %Trend liniowy
% line = linspace(min(data), max(data), size((data), 1))';
% PF_linear = polyfit(line, data, 1);
% PV_linear = polyval(PF_linear, line);
% 
% %Trend wielomianowy 4. stopnia
% PF_polynomial = polyfit(line, data, 4);
% PV_polynomial = polyval(PF_polynomial, line);
% 
% %Wizualizacja trendów
% visualize_trends(data_dates_plot,data,PV_linear,PV_polynomial);
% 
% % %Test KPSS stacjonarnoœci szeregu
% KPSS_test(data,data_diffs);
% % % stacjonarne pierwsze przyrosty

% Wybrana metoda prognozowania - model addytywny Wintersa
% Ft – oszacowanie czêœci sta³ej szeregu podlegaj¹cej wahaniom przypadkowym,
% St – oszacowanie czêœci przyrostowej szeregu, równie¿ podlegaj¹cej wahaniom przypadkowym,
% Ct – oszacowanie czêœci sezonowej trendu, te¿ nastawionej na dzia³anie czynnika losowego,
% Yt – wartoœci empiryczne szeregu w okresach od 1 do t,
% Yt* – wartoœci teoretyczne szeregu wyg³adzonego.
% 
% Sta³e wyg³adzania:
% 0 < a,b,g < 1
% 
% Dodatkowe oznaczenie:
% r - liczba sezonów w jednym cyklu
loops = 10000; %generowanie parametrów a,b,c, ¿eby zminimalizowaæ RMSE

% W³aœciwa prognoza z wyprzedzeniem 1
f_period_1 = 1; %okres prognozy
[a,b,c] = fit_parameters_Winters(data,f_period_1,loops);
[forecast_1,RMSE_1,real_data_1,real_data_dates_plot_1] = forecast_Winters(index,dates,data,f_period_1,a,b,c);
% Wizualizacja prognozy
visualize_forecast(real_data_dates_plot_1,real_data_1,forecast_1,f_period_1,RMSE_1);
visualize_data_and_forecast(data_dates_plot,data,real_data_dates_plot_1,real_data_1,forecast_1,f_period_1,RMSE_1);

% W³aœciwa prognoza z wyprzedzeniem 5
f_period_5 = 5; %okres prognozy
[a,b,c] = fit_parameters_Winters(data,f_period_5,loops);
[forecast_5,RMSE_5,real_data_5,real_data_dates_plot_5] = forecast_Winters(index,dates,data,f_period_5,a,b,c);
% Wizualizacja prognozy
visualize_data_and_forecast(data_dates_plot,data,real_data_dates_plot_5,real_data_5,forecast_5,f_period_5,RMSE_5);
visualize_forecast(real_data_dates_plot_5,real_data_5,forecast_5,f_period_5,RMSE_5);

% W³aœciwa prognoza z wyprzedzeniem 10
f_period_10 = 10; %okres prognozy
[a,b,c] = fit_parameters_Winters(data,f_period_10,loops);
[forecast_10,RMSE_10,real_data_10,real_data_dates_plot_10] = forecast_Winters(index,dates,data,f_period_10,a,b,c);
% Wizualizacja prognozy
visualize_data_and_forecast(data_dates_plot,data,real_data_dates_plot_10,real_data_10,forecast_10,f_period_10,RMSE_10);
visualize_forecast(real_data_dates_plot_10,real_data_10,forecast_10,f_period_10,RMSE_10);

% W³aœciwa prognoza z wyprzedzeniem 20
f_period_20 = 20; %okres prognozy
[a,b,c] = fit_parameters_Winters(data,f_period_20,loops);
[forecast_20,RMSE_20,real_data_20,real_data_dates_plot_20] = forecast_Winters(index,dates,data,f_period_20,a,b,c);
% Wizualizacja prognozy
visualize_data_and_forecast(data_dates_plot,data,real_data_dates_plot_20,real_data_20,forecast_20,f_period_20,RMSE_20);
visualize_forecast(real_data_dates_plot_20,real_data_20,forecast_20,f_period_20,RMSE_20);

RMSE = table(RMSE_1, RMSE_5, RMSE_10, RMSE_20);
disp(RMSE);