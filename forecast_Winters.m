function [forecast,RMSE,real_data,real_data_dates_plot] = forecast_Winters(index,dates,data,f_period,a,b,c)
%   FORECAST_WINTERS
%   Prognoza danych za pomoc¹ modelu Wintersa z wykorzystaniem parametrów
%   a,b,c wyznaczonych funkcj¹ fit_parameters_Winters
    L = length(data); 
    r = f_period;
    
    F = zeros(L,1); S = F;
    C = zeros(L+f_period,1);

    F(f_period,1) = data(f_period);

    S(f_period,1) = sum(data(1:2*f_period))/f_period-sum(data(1:f_period))/f_period;

    mean_i_in_f_period = mean(data(1:f_period));
    for m = 1:f_period
        C(m,1) = data(m) - mean_i_in_f_period;
    end

    for t = f_period+1:L
        y = data(t);
        F(t,1) = a*(y - C(t-r,1))+(1-a)*(F(t-1,1)+S(t-1,1));
        S(t,1) = b*(F(t,1)-F(t-1,1))+(1-b)*S(t-1,1);
        C(t,1) = c*(y - F(t,1))+(1-c)*C(t-r,1);
    end

    forecast = zeros(f_period,1);

    for T = 1:f_period
        forecast(T,1)= F(L,1) + S(L,1)*T + C(L-f_period+T);
    end
    
    %Dane historyczne z okresu prognozowanego (do oceny prognozy ex post)
    real_data = index(2562+1:2562+f_period,:);
    real_data_diffs = diff(real_data);
    real_data_dates = dates(2562+1:2562+f_period,:);
    real_data_dates_plot = datenum(real_data_dates);
    
    %RMSE
    real_data = index(2562+1:2562+f_period,:);
    RMSE = sqrt(mean((real_data-forecast(1:f_period,:)).^2));
end

