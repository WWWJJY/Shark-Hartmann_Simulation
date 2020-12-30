function Iout = SH_sense(args,sh,Uin,method)
% Shark-Hartmann ���к���
% args: ��ع�ѧ���������
% sh: Shark-Hartmann �������ṹ��
% Uin: ���벨ǰ
% method: ���м��㷽��
% Iout: ����ǿ��

Uin = Uin.*sh.SHTrans;
if method == 1
    Uout = FresnelProp(args,Uin,args.fOfMicroLens,sh.delta_pp,sh.delta_ip);
else
    Uout = zeros(size(Uin));
    h = waitbar(0,'����ǿ�ȼ�����...');
    for i=1:size(sh.lensCoors,1)
        tmpcoor = sh.lensCoors(i,:);
        half = floor(args.n_pixelOfLen/2);
        tmpin = Uin(tmpcoor(2)-half:tmpcoor(2)+half,tmpcoor(1)-half:tmpcoor(1)+half);
        tmpout = FresnelProp(args,tmpin,args.fOfMicroLens,sh.delta_pp,sh.delta_ip);
        Uout(tmpcoor(2)-half:tmpcoor(2)+half,tmpcoor(1)-half:tmpcoor(1)+half) = tmpout;
        if mod(i,50)==0
            waitbar(i/size(sh.lensCoors,1));
        end
    end
    close(h);
end
Iout = Uout.*conj(Uout);
    