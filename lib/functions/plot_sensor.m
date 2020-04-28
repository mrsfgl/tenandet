% function plot_sensor(X, Y, D, U, checkSens, modes)
% %UNTITLED2 Summary of this function goes here
% %   Detailed explanation goes here
% 
% Yp = mergeTensors(Y, U(1:length(modes)), modes);
% Yp = permute(squeeze(mergeFactors({Yp, U{length(modes)+1:end}})), ndims(Y):-1:1);
% 
% for i=1:size(X,3)
% figure,
% subplot(2,3,1)
% plot(X(:,1:10,i,checkSens))
% subplot(2,3,2)
% plot(Y(:,1:10,i,checkSens))
% subplot(2,3,4)
% plot((X(:,1:10,i,checkSens)-D(:,1:10,i,checkSens)))
% subplot(2,3,5)
% plot(Yp(:,1:10,i,checkSens))
% subplot(2,3,6)
% plot(sign(Yp(:,1:10,i,checkSens)))
% end
% 
% end

function plot_sensor(X, Y, B, U, checkSens, modes)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
M = ndims(Y);
% m = length(modes);
% Yp = mergeTensors(Y, U(1:m), modes);
% Yp = ipermute(squeeze(mergeFactors({Yp, U{m+1:end}})),  [setdiff(1:M, modes), modes(end:-1:1)]);
imodes = setdiff(1:M, modes);
sz = size(Y);
Yp = reshape(U*t2m(Y, modes), [sz(modes), sz(imodes)]);
Yp = ipermute(Yp, [modes, imodes]);

for i=1:size(Y,3)
    figure,
    subplot(3,2,1)
    plot(X(:,:,i,checkSens))
    subplot(3,2,2)
    plot(Y(:,:,i,checkSens))
    subplot(3,2,3)
    plot((Yp(:,:,i,checkSens)+B(:,:,i)))
    subplot(3,2,4)
    plot(sign((Yp(:,:,i,checkSens)+B(:,:,i))))
    subplot(3,2,5)
    plot(Yp(:,:,i,checkSens))
    subplot(3,2,6)
    plot(sign(Yp(:,:,i,checkSens)))
end

end

