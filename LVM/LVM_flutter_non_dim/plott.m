p=30000;
for i=29000:(p+1)
a=cell2mat(circ_coord_cell(i,1));
b=cell2mat(circ_cell(i,1));
I1=find(b>=0);
I2=find(b<0);
positive=zeros(size(I1,1),2);
negative=zeros(size(I2,1),2);
for p=1:size(I1,1)
    positive(p,:)=a(I1(p),:);
end
for p=1:size(I2,1)
    negative(p,:)=a(I2(p),:);
end

plot(positive(:,1),positive(:,2),'.');
hold on
plot(negative(:,1),negative(:,2),'.','MarkerFacecolor','red','MarkerEdgecolor','red');
hold off
pause(0.1);
F(i)=getframe(gcf);
end
% F_1=F(1:2000);
% movie2avi(F_1, 'movie4.avi', 'compression', 'None');