%%% Genetic Algorithms
%%% Program by RickyCga, 10/06/16
function ProGeneA()
close all;tic;

%%% setting of Genetic Algorithms %%%
iniNumberGene=450; % number of parent Generation
generateTime=10000; % number of generate
mutationRate=0.01; % probability of mutation
stepRange=1;  % number of reproduced Generation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Create Point Information %%%
city=10*rand(2,20);
x=1:size(city,2);
randx=city(1,:);
randy=city(2,:);
point=city;
plot(randx,randy,'.','markersize',10) % plot all city
hold on
axis([min(randx)-1 max(randx)+1 min(randy)-1 max(randy)+1])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Create Parent Genetic %%%
Gene=[];
for i=1:iniNumberGene
    Gene=[Gene; reshape(x(randperm(numel(x))),size(x,1),size(x,2))]; % randon initial Genetic
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Create Cost Func %%%
Ff=['@(point, Gene)norm(point(:,Gene(' num2str(length(x)) '))-point(:,Gene(' num2str(1) ')))'];
for i=length(x):-1:2
    Ff=[Ff '+norm(point(:,Gene(' num2str(i) '))-point(:,Gene(' num2str(i-1) ')))'];
end
Ffunc=str2func(Ff); % for calculate distance of travel
%%%%%%%%%%%%%%%%%%%%%%%%

%%% start of the Universe %%%
stepRealminiDistance=1000;
for i=1:generateTime
    %%% main Generation %%%
    [minGene, minDistance, Fitness, Distance]=calFitness(Ffunc, Gene, point);
    [Gene, Fitness]=selection(Gene, Fitness);
    Gene=crossOver(Gene, Fitness, mutationRate, stepRange);
    %%%%%%%%%%%%%%%%%%%%%%%
    minDistance
    %%% record appeared minDistance & minGene %%%
    stepRealminiDistance=min(stepRealminiDistance, minDistance)
    if stepRealminiDistance==minDistance
        stepRealminGene=minGene;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if toc>60
        break;
    end
    hold off
    plot(randx,randy,'.','markersize',10)
    hold on
    drawLine(stepRealminGene, point);
    pause(0.000001)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[minGene, minDistance, Fitness, Distance]=calFitness(Ffunc, Gene, point);

stepRealminiDistance=min(stepRealminiDistance, minDistance)
if stepRealminiDistance==minDistance
    stepRealminGene=minGene;
end
%hold off
%%% Answer & Draw %%%
%plot(randx,randy,'.','markersize',10)
hold on
stepRealminGene
stepRealminiDistance
drawLine(stepRealminGene, point);
%%%%%%%%%%%%%%%%%%%%%
toc;
end












%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% subFunction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

function Gene=mutation(Gene, fitness)
%%% mutate Random Genetic with low fitness %%%
x=1:size(Gene,2);
randomRandom=randsample(1:size(Gene,1),1,true,(10-fitness)/10); %
Gene(randomRandom,:)=reshape(x(randperm(numel(x))),size(x,1),size(x,2)); % Genetic mutate to randomGene
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

function drawLine(minGene, point)
%%% draw line with minGene %%%
for i=1:length(minGene)-1
    line([point(1,minGene(i)), point(1,minGene(i+1))], [point(2,minGene(i)), point(2,minGene(i+1))]);
end
line([point(1,minGene(end)), point(1,minGene(1))], [point(2,minGene(end)), point(2,minGene(1))])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
