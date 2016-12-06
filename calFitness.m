function [minGene, minDistance, fitness, Distance]=calFitness(Ffunc, Gene, point)
%%% choose best Gene %%%
Distance=[];
for i=1:size(Gene,1)
    Distance=[Distance; Ffunc(point, Gene(i,:))];
end
[miniDistance minIndex]=min(Distance);
minGene=Gene(minIndex,:);
%%%%%%%%%%%%%%%%%%%%%%%%

%%% calculate Fitness %%%
minDistance=Distance(minIndex);
maxDistance=max(Distance);
fitness=[];
for i=1:size(Gene,1)
    fitness=[fitness, abs(1-(Distance(i)-miniDistance)/((maxDistance-minDistance)))*.65];
end
%%%%%%%%%%%%%%%%%%%%%%%%%

%%% fix fitness %%%
fitness=(fitness/100).^3;
minfitness=min(fitness);
maxfitness=max(fitness);
fitness=abs((fitness-minfitness)/(maxfitness*2.5-minfitness)*0.65);
%%%%%%%%%%%%%%%%%%%
end
