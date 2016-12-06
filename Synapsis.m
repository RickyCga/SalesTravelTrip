function [GeneChild]=Synapsis(Gene1,Gene2)
%%% Synapsis for change Genetic with Maximal Preservative Crossover (MPX) %%%
breakFitness=(ones(1,length(Gene1)).*(randn(1,length(Gene1)))+fliplr(ones(1,length(Gene1)).*(randn(1,length(Gene1)))))*(rand(1)^2);
breakPoint=sort(randsample(1:length(Gene1),2,true,abs(breakFitness.*randn(1,length(breakFitness)))));
subTour1=Gene1(breakPoint(1):breakPoint(2));
subTour2=Gene2(breakPoint(1):breakPoint(2));
for n=1:length(subTour1)
    Gene1(find(Gene1==subTour2(n)))=[];
    Gene2(find(Gene2==subTour1(n)))=[];
end
Child1=[subTour1, Gene2];
Child2=[subTour2, Gene1];
GeneChild=[Child1; Child2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
