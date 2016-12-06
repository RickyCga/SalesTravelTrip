function Gene=mutation(Gene, fitness)
%%% mutate Random Genetic with low fitness %%%
x=1:size(Gene,2);
randomRandom=randsample(1:size(Gene,1),1,true,(10-fitness)/10); %
Gene(randomRandom,:)=reshape(x(randperm(numel(x))),size(x,1),size(x,2)); % Genetic mutate to randomGene
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
