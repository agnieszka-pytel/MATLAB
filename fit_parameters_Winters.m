function [a,b,c,RMSE_n] = fit_parameters_Winters(data,f_period,loops)
%   FIT_PARAMETERS_WINTERS 
%   wyznaczenie wartoœci sta³ych wyg³adzenia metod¹ minimalizowania b³êdu
%   œredniokwadratowego prognoz wygas³ych
    RMSE_n = zeros(loops,1);
    L = length(data); 
    r = f_period;

    for n = 1:loops
        a_n = rand; b_n = rand; c_n = rand;

        F_N = zeros(L,1); S_N = F_N;
        C_N = zeros(L+f_period,1);

        F_N(f_period,1) = data(f_period);

        S_N(f_period,1) = sum(data(1:2*f_period))/f_period-sum(data(1:f_period))/f_period;

        mean_i_in_f_period = mean(data(1:f_period));
        for m = 1:f_period
            C_N(m,1) = data(m) - mean_i_in_f_period;
        end

        for t = f_period+1:L
        y = data(t);
        F_N(t,1) = a_n*(y - C_N(t-r,1))+(1-a_n)*(F_N(t-1,1)+S_N(t-1,1));
        S_N(t,1) = b_n*(F_N(t,1)-F_N(t-1,1))+(1-b_n)*S_N(t-1,1);
        C_N(t,1) = c_n*(y - F_N(t,1))+(1-c_n)*C_N(t-r,1);
        end

        forecast_N = zeros(L,1);

        for T = f_period+1:L
            forecast_N(T,1)= F_N(T-1,1) + S_N(T-1,1) + C_N(T-f_period);
        end

        RMSE_n(n,1) = sqrt(mean((data(f_period+1:end,:)-forecast_N(f_period+1:end,:)).^2));

        if n == 1
            min_RMSE = RMSE_n(n,1);
        else
            if RMSE_n(n,1) < min_RMSE
                a = a_n;
                b = b_n;
                c = c_n;
            end
        end
    end
end

