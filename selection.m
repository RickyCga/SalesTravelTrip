function [Gene, fitness]=selection(Gene, fitness)
%%% extinction event %%%
LimitGene=1000;
if size(Gene,1)>LimitGene
    z=zeros(1,length(fitness));
    mark=sort(randsample(1:size(Gene,1),floor(LimitGene*.45),true,(fitness/100).^4));
    z(mark)=1;
    z=logical(z);
    Gene(~z,:)=[];
    fitness(~z)=[];
end
%%%%%%%%%%%%%%%%%%%%%%%

%%% eliminate low Fitness Gene %%%
for j=size(Gene,1):-1:1
    if fitness(j)<=0.15
        Gene(j,:)=[];
        fitness(j)=[];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
