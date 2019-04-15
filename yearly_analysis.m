function [bp,mean_yearly,median_yearly,var_yearly,std_yearly,skew_yearly] = yearly_analysis(index_yearly)
%	YEARLY_ANALYSIS 
%   Analiza danych w ujeciu rocznym
    [unique_ids,~,idmatch_indx] = unique(index_yearly(:,1)); 
    figure('Name','Analiza danych w ujeciu rocznym');
    bp = boxplot(index_yearly(:, 2), index_yearly(:, 1));
    mean_yearly = [unique_ids accumarray(idmatch_indx,index_yearly(:,2), [], @mean)];
    median_yearly = [unique_ids accumarray(idmatch_indx,index_yearly(:,2), [], @median)];
    var_yearly = [unique_ids accumarray(idmatch_indx,index_yearly(:,2), [], @var)];
    std_yearly = [unique_ids accumarray(idmatch_indx,index_yearly(:,2), [], @std)];
    skew_yearly = [unique_ids accumarray(idmatch_indx,index_yearly(:,2), [], @skewness)];
end

