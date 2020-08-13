
param.theta = 1/(sum(std(t2m(Yn,4),[],2).^2));
param.alpha = 0;
param.beta_1 = 1/(5*std(Yn(setdiff(1:numel(Yn), ind_removed))));
param.beta_2 = param.beta_1*1;
param.beta_3 = param.beta_1/1;
param.beta_4 = param.beta_1/1;
param.max_iter = 100;
tic;
[L_logss,S_logss,~] = logss(Yn, param);
rmse_logss(ind_outer) = norm(L_logss(:)-Y_gen(:))/sqrt(numel(Y_gen));
mape_logss(ind_outer) = sum(abs(L_logss-Y_gen),'all')/numel(Y_gen);
time_logss = toc
%% Envelope Analysis
if ind_outer == length(anom_list)
%     [fpr_gloss_en, recall_gloss_en] = analyze_envelope(S, X, ind_removed);
end
%% Top-K Analysis
[k_list(:,ind_outer), precision_logss(:,ind_outer), recall_logss(:,ind_outer), fpr_logss(:,ind_outer)] = analyze_top_K(mahal_dist(S_logss), X, ind_removed);
%% Visualize Decomposition
% plot_sensor_new(X, Yn, S, L, 5)
% plot_sensor_new(permute(X,[1,3,2,4]), permute(Yn,[1,3,2,4]), permute(S,[1,3,2,4]), permute(L,[1,3,2,4]), 5)
if ~nodisp
%     plot_sensor_new(permute(X,[1,3,4,2]), permute(Yn,[1,3,4,2]), permute(S,[1,3,4,2]), permute(L,[1,3,4,2]), 3,30)
end
if ind_outer == length(anom_list)
    %     plot_sensor_new(permute(X,[1,3,2,4]), permute(Yn,[1,3,2,4]), permute(S,[1,3,2,4]), permute(L,[1,3,2,4]), 5)
end
% a_S = apply_lof(mahal_dist(S), 10);
% plot_sensor_new(permute(a_S,[1,3,4,2]), permute(Yn,[1,3,4,2]), permute(mahal_dist(S),[1,3,4,2]), permute(S,[1,3,4,2]), 3,30)
if ~nodisp
    a_S = apply_lof(S_logss, 10);
    plot_sensor_new(permute(X,[1,3,4,2]), permute(Yn,[1,3,4,2]), permute(mahal_S,[1,3,4,2]), permute(S_logss,[1,3,4,2]), 3,30)
    
    figure,
    plot(fpr_gloss_en,recall_gloss_en,'DisplayName','LOGSS')
    legend, grid
    title('ROC of the envelope')
    
    figure,
    plot(k_list, precision_logss,'DisplayName','LOGSS');
    legend, grid
    title('Precision')
    
    figure,
    plot(k_list, recall_logss,'DisplayName','LOGSS');
    legend, grid
    title('Recall')
end