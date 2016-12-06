function drawLine(minGene, point)
%%% draw line with minGene %%%
for i=1:length(minGene)-1
    line([point(1,minGene(i)), point(1,minGene(i+1))], [point(2,minGene(i)), point(2,minGene(i+1))]);
end
line([point(1,minGene(end)), point(1,minGene(1))], [point(2,minGene(end)), point(2,minGene(1))])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
