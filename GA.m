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
