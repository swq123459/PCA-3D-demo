function PCAdemo
close all;clear;clc;
h_figure=figure;
mu=[0 0 0];
%Э������󣬶Խ�Ϊ����ֵ0.3��0.35
dim=3;
var=[0.2 0 0;0 0.5 0;0 0 0.8];
samNum=100;
data=mvnrnd(mu,var,samNum);
h_plotMain=plot3(gca,data(:,1),data(:,2),data(:,3),'o','MarkerSize',5,'MarkerFaceColor','k');
 xlim([-2 2]);ylim([-2 2]);zlim([-2 2]);
grid on;axis square;hold on;
pause();
covdata = cov(data);%��Э�������
[eigVector, eigValue]=eig(covdata);%��Э������������ֵ����������
eigValue=diag(eigValue)';
% struct_eig = struct;
% for i=1:3
%      struct_eig(i).vector=eigVector(:,i);
%      struct_eig(i).value=eigValue(i);
% end
[eigValue_sort,IX]=sort(eigValue,2,'descend');
eigVector_sort=[];
for i=1:dim
    tempIX=IX(i);
    eigVector_sort=[eigVector_sort eigVector(:,tempIX)];
end
base_3to2=eigVector_sort(:,1:2);%��ά��2ά
base_3to1=eigVector_sort(:,1);%��ά��1ά
base_3to2=base_3to2';
base_3to1=base_3to1';
%%%%%����3ά���2ά�ȵ�ͶӰƽ��%%%%%
A=base_3to2(1,:);%�»�iñ(���ԭ��)
B=base_3to2(2,:);%�»�jñ(���ԭ��)
C=[0 0 0];
syms x y z;
D=[ones(4,1),[[x,y,z];A;B;C]];%�ɿռ�������ε�����֪��D������ʽ���������ƽ�淽�̡�
detd=det(D);
z=solve(detd,z);
ezmesh(z,[-2, 2, -2, 2]);
% alpha(0.3);
pause();
%%%%%%%%%%%%
data_proj3_2=base_3to2*data';%ͶӰ���»�����(����»�)
data_proj3_1=base_3to1*data';%ͶӰ���»�����(����»�)

data_proj3_2=data_proj3_2';
data_proj3_1=data_proj3_1';

data_proj_respect_to_orienbasis3_2=[];%�»�������ԭ����ʾ
data_proj_respect_to_orienbasis3_1=[];%�»�������ԭ����ʾ
for i=1:samNum
    data_proj_respect_to_orienbasis3_2=[data_proj_respect_to_orienbasis3_2;...
        data_proj3_2(i,1)*base_3to2(1,:)+data_proj3_2(i,2)*base_3to2(2,:)];   
    data_proj_respect_to_orienbasis3_1=[data_proj_respect_to_orienbasis3_1;...
        data_proj3_1(i)*base_3to1(1,:)];   
end

%����3ά��Ϊ2ά�������
h_plot3_2=plot3(gca,data_proj_respect_to_orienbasis3_2(:,1),...
    data_proj_respect_to_orienbasis3_2(:,2),data_proj_respect_to_orienbasis3_2(:,3),...
    'o','MarkerSize',5,'MarkerEdgeColor','g','MarkerFaceColor','g');

%����3ά��Ϊ2��ͶӰ����
hl3_2=[];
hl3_1=[];
  for i=1:samNum
      dd=[data_proj_respect_to_orienbasis3_2(i,:);data(i,:)];
     hl3_2(i)=plot3(gca,dd(:,1),dd(:,2),dd(:,3),'-.','markersize',10);
  end
  pause();
 delete(h_plotMain);delete(hl3_2);
 pause();
 %����3ά��Ϊ1�Ļ�׼��
 h_zhixian=plot3(gca,data_proj_respect_to_orienbasis3_1(:,1),...
      data_proj_respect_to_orienbasis3_1(:,2),data_proj_respect_to_orienbasis3_1(:,3),...
      'color','r','linewidth',2);
  pause();
 %����3ά��Ϊ1������
  h_plot3_1=plot3(gca,data_proj_respect_to_orienbasis3_1(:,1),...
      data_proj_respect_to_orienbasis3_1(:,2),data_proj_respect_to_orienbasis3_1(:,3),...
    'o','MarkerSize',5,'MarkerEdgeColor','r','MarkerFaceColor','r');
 %����3ά��Ϊ1��ͶӰ����
for i=1:samNum
    dd=[data_proj_respect_to_orienbasis3_1(i,:);data_proj_respect_to_orienbasis3_2(i,:)];
     hl3_1(i)=plot3(gca,dd(:,1),dd(:,2),dd(:,3),'-.','markersize',10);
end
pause();
 delete(h_plot3_2);delete(hl3_1); delete(h_zhixian); 
end 