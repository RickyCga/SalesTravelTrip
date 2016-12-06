function [Gene]=crossOver(Gene, fitness, mRate, stepRange)
%%% mutation %%%
mu=ones(1, round(floor((1.05+mRate)*rand(1))*size(Gene,1)*mRate));
for i=1:length(mu)
    Gene=mutation(Gene, fitness);
end
%%%%%%%%%%%%%%%%

%%% random Choose and Synapsis %%%
parent=ceil(size(Gene,1)*0.06*rand(1)^4)+1;
geneChild=[];
for j=1:parent
    crossParent=randsample(1:size(Gene,1),2,true,fitness);
    for i=1:stepRange
        geneChild=[geneChild; Synapsis(Gene(crossParent(1),:),Gene(crossParent(2),:))];
    end
end
Gene=[Gene; geneChild];
%%%%%%%%%%%%%%%%%
end
