%stats_genotype_gender script
%test script for running stats for when gender = true in data set

%stats by gender and genotype (if gender = true in function input)
for ii = 1:size(NMJ_array,2)
%test generalized linear model with several distributions for each set of
%measurements - poisson, normal, lognormal, gamma
%also need to test beta distribution fit - separate command
fitglm(NMJ_array(:,ii));
%how to add model: Measurement~Genotype*Gender
end