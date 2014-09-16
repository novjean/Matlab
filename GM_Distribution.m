%specify the number of clusters
clusters=3;
%load the file to matlab
load gmm.txt;
values=gmm(:,1:2);
scatterplot(values);
%the means
m1=[0.5 2];
m2=[-2 -1];
m3=[6.5 0];
%the identity matrix
id =[1 0 ; 0 1]; 
%the sigma values same as 2x2 identitiy matrix I
sig1=id;
sig2=id;
sig3=id;
%the probability of 1/3
prob=1/3;
%generating the clusters according to the values
obj1=gmdistribution(m1,sig1,prob);
obj2=gmdistribution(m2,sig2,prob);
obj3=gmdistribution(m3,sig3,prob);
%display the cluster according the values
figure;
gscatter(values(:,1), values(:,2)), hold on
ezcontour(@(x,y)pdf(obj1,[x y]), xlim(), ylim()), hold on 
ezcontour(@(x,y)pdf(obj2,[x y]), xlim(), ylim()), hold on
ezcontour(@(x,y)pdf(obj3,[x y]), xlim(), ylim());
%cluster formation based on posterior
object=gmdistribution.fit(values,clusters);
%calculating the posterior
post = posterior(object,values);
[~,argMax] = max(post,[],2);
%display the mean sigma and Pcomponents of gmm
object.mu;
object.Sigma;
object.PComponents;
% The original data cluster formation
figure;
gscatter(values(:,1), values(:,2))
% to draw without the contours
figure;
gscatter(values(:,1), values(:,2), argMax);
% to draw with contours
figure;
gscatter(values(:,1), values(:,2), argMax), hold on
ezcontour(@(x,y)pdf(object,[x y]), xlim(), ylim());
