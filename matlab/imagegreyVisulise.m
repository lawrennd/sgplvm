function handle = imagegreyVisualise(pos,fid,imageSize)

if(nargin<2)
  fid = 2;
end

figure(fid);
colormap gray;

imageData = reshape(pos, imageSize(1), imageSize(2));
imageData = imageData./max(max(imageData));
imagesc(imageData);

return;