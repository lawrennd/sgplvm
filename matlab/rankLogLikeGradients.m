function [g g_a g_g] = rankLogLikeGradients(model)

% RANKLOGLIKEGRADIENTS Compute the FOLS rank constraint gradients for the SGPLVM.
% FORMAT
% DESC Returns the gradients of the log likelihood with respect to
% the latent locations of the model
% ARG model : sgplvm model
% RETURN g : the gradients of the latent positions
%
% SEEALSO : ranksgplvmLogLikelihood, sgplvmCreate,
% modelLogLikeGradients
%
% COPYRIGHT : Neil D. Lawrence, Carl Henrik Ek, Mathieu Salzmann, 2009

% SGPLVM


if(isfield(model.fols,'rank')&&~isempty(model.fols.rank))
  %shared rank
  start = model.fols.qs;
  g = zeros(model.N,model.q);
  g_a = zeros(model.N,model.q);
  g_g = zeros(model.N,model.q);
  %private ranks
  for(i = 1:1:length(model.fols.qp))
    inds = find(model.generative_id(i,:));
    [U,S,V] = svd(model.X(:,inds));
    S2 = S(1:length(inds),1:length(inds))*S(1:length(inds),1:length(inds));
    dPhi_dS = (2*model.fols.rank.beta.weight*(S(1:length(inds),1:length(inds))./model.fols.rank.alpha.rel_alphas(i)))./(1+model.fols.rank.beta.weight*S2/model.fols.rank.alpha.rel_alphas(i));
    
    tmp = (model.fols.rank.alpha.weight)*(U(:,1:length(inds))*dPhi_dS*V');

    g_a(:,inds) = g_a(:,inds) - tmp;
    g(:,inds) = g(:,inds) - tmp;

    %energy loss penalty
    if(model.fols.rank.gamma.weight > 0)
      ddE_dS = -4*(model.fols.sumS2(i) - sum(diag(S2)))*S(1:length(inds),1:length(inds));

      tmp = (model.fols.rank.gamma.weight/model.fols.rank.alpha.rel_alphas(i))*(U(:,1:length(inds))*ddE_dS*V');
      
      g_g(:,inds) = g_g(:,inds) - tmp;
      g(:,inds) = g(:,inds) - tmp;
    end
    start = start+model.fols.qp(i);
  end
else
  g = [];
  g_a = [];
  g_g = [];
end

return