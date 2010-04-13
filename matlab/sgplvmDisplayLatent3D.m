function [XTest, mu] = sgplvmDisplayLatent3D(model, varargin)

% GPLVMVISUALISE Visualise the manifold.

q = size(model.X,2);
x = [];
m = 20;
bigm = 50;
for n = 1:q
	x{n} = linspace(min(model.X(:, n))*1.1, max(model.X(:, n))*1.1, m);
end

[X1, X2, X3] = meshgrid(x{1}, x{2}, x{3});
XTest = [X1(:), X2(:), X3(:)];

fhandle = str2func([model.type 'fgplvmPointLogLikelihood']);
if str2num(version('-release'))>13
  [mu, varsigma] = fhandle(model, XTest);
else 
  [mu, varsigma] = feval(fhandle, model, XTest);
end

Z = zeros(m, m, m);
Z = log10(reshape(1./varsigma(:,1), m, m, m));
for n = 1:q
	x{n} = linspace(min(model.X(:, n))*1.1, max(model.X(:, n))*1.1, bigm);
end
[X1i, X2i, X3i] = meshgrid(x{1}, x{2}, x{3});
Zi = interp3(X1, X2, X3, Z, X1i, X2i, X3i); 

h = vol3d('cdata',Zi,'texture','3D');
SX = model.X;
for n = 1:q
   diff = (max(model.X(:,n)) - min(model.X(:,n)));
   SX(:,n) = ((bigm-1)/(1.1*diff))*SX(:,n) + (0.5 - (bigm-1)*min(model.X(:,n))/diff);
end
plot3(SX(:,1), SX(:,2), SX(:,3), ['k' 'x']);
vol3d(h);
hold on;
%set(gcf, 'Renderer', 'OpenGL');
%shading flat
alphamap('rampup');
alphamap(.06 .* alphamap);

if nargin>7
    vY = varargin{4};
    mY = varargin{5};
end

if nargin>5
    inds1 = varargin{2};
    inds2 = varargin{3};
end

h1 = plot3(SX(1,1), SX(1,2), SX(1,3), 'or', 'MarkerSize',10);
hold off;
% if(~isempty(visualiseFunction))
%     figure;
%     h2 = visualiseFunction(model.y(1,:),[],inds1,inds2,vY,mY);
% end
%pause;

for i=2:size(SX,1)
    set(h1,'XData',SX(i,1),'YData',SX(i,2),'ZData',SX(i,3));
%     if(~isempty(visualiseFunction))
%         visualiseModify(h2,model.y(i,:),[],inds1,inds2,vY,mY);
%     end
    %pause;
end
pause(2);
