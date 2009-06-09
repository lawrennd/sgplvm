function [qs,qp] = sgplvmComputeDimensions(model,eps)

S = svd(model.X(:,1:model.qs));
tmp = S(1:end-1)./(S(2:end)+eps);
[m,indm] = max(tmp);
qs = indm;

qp = zeros(size(model.qp));
start = model.qs;
for i=1:length(qp)
    S = svd(model.X(:,start+1:start+model.qp(i)));
    tmp = S(1:end-1)./(S(2:end)+eps);
    [m,indm] = max(tmp);
    qp(i) = indm;
    start = start+model.qp(i);
end
