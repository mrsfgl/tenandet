function detected = detect_real_events(S, ind_removed, num_k)


if nargin==2
    num_k = 7000;
end
load('dates.mat', 'dates');
load('regions.mat', 'regions');
num_anom = min(size(dates,2),20);

ind_rem = setdiff(1:numel(S), ind_removed);
[~, ind] = sort(abs(S(ind_rem)),'descend');
ind = ind_rem(ind);
[i_1, i_2, i_3, i_4] = ind2sub(size(S), ind(1:num_k)');

detected = zeros(1,num_anom);
for i=1:num_anom
    [s_h, s_d, s_w] = date2ind(dates{1,i}(1));
    [e_h, e_d, e_w] = date2ind(dates{1,i}(2));
    if e_d~=s_d || s_w~=e_w
        error('Check dates!')
    end
    det_hours = s_h:e_h;
    for j = 1:length(dates{3,i})
        roi = repmat([s_d, s_w, find(regions==dates{3,i}(j))], length(det_hours),1);
        det_inds = [det_hours', roi];
        if ~isempty(intersect(det_inds, [i_1, i_2, i_3, i_4],'rows'))
            detected(i) = true;
            break;
        end
    end
end
end
