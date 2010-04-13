function model = sgplvmOrderX(model)

[D,V] = eigdec(model.X(:,1:model.qs)'*model.X(:,1:model.qs),model.qs);
model.X(:,1:model.qs) = model.X(:,1:model.qs)*V(:,1:model.qs);
start = model.qs;
for i=1:length(model.qp)
    dim = start+1:start+model.qp(i);
    [D,V] = eigdec(model.X(:,dim)'*model.X(:,dim),length(dim));
    model.X(:,dim) = model.X(:,dim)*V(:,1:model.qp(i));
    start = start + model.qp(i);
end
