function coffes = zernikeCoffes(img,zernPolys)
% ����img��zernikeϵ��
coffes = zeros(size(zernPolys,3),1);
for i=1:size(zernPolys,3)
    coffes(i) = sum(sum(img.*zernPolys(:,:,i)));
end