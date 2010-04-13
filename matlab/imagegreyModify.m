function handle = imagegreyModify(handle,imageValues,imageSize)

set(handle, 'CData', reshape(imageValues, imageSize(1),imageSize(2)));

return