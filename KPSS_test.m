function [] = KPSS_test(data,data_diffs)
%	KPSS_TEST
%   Testowanie stacjonarnoœci szeregu czasowego
    h0 = kpsstest(data);
    if h0 == 1 
        disp('rejection of the trend-stationary null in favor of the unit root alternative');
    else
        disp('failure to reject the trend-stationary null');
    end
    h1 = kpsstest(data_diffs);
    if h1 == 1 
        disp('rejection of the trend-stationary null in favor of the unit root alternative');
    else
        disp('failure to reject the trend-stationary null');
    end
end

