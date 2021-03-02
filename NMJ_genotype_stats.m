
function [data_dist,data_mod, data_signif] = NMJ_genotype_stats(NMJ_data,col_num)
%NMJ_GENOTYPE_STATS Find best fit distribution and runs stats on NMJ
%morphology data, prints output and signficance of generalized linear model
%with best fit distribution
% Created by K2M for Project 1 on 03.01.21

col_name = char(NMJ_data.Properties.VariableNames(col_num));
disp(col_name);
geno_var = {' ~ Genotype'};
mod_cell = strcat(col_name, geno_var);
mod_spec = char(mod_cell);
disp(mod_spec);
NMJ_log = NMJ_data;
NMJ_log(1:end, col_name) = varfun(@log,NMJ_log,'InputVariables',col_name);

%specify model (eventually use for loop to go through all columns?)
%fit generalized linear model with possible distributions - normal, gamma,
%lognormal, poisson, beta
modelspec = (mod_spec);
AIC_vec = [];
norm_mod = fitglm(NMJ_data, modelspec, 'Distribution', 'normal');
AIC_vec = [AIC_vec, norm_mod.ModelCriterion.AICc];
gam_mod = fitglm(NMJ_data, modelspec, 'Distribution', 'gamma');
AIC_vec = [AIC_vec, gam_mod.ModelCriterion.AICc];
log_mod = fitglm(NMJ_log, modelspec, 'Distribution', 'normal');
AIC_vec = [AIC_vec, log_mod.ModelCriterion.AICc];
pois_mod = fitglm(NMJ_data, modelspec, 'Distribution', 'poisson');
AIC_vec = [AIC_vec, pois_mod.ModelCriterion.AICc];

if col_num == 15 || col_num == 17
    openR;
% Create a MATLAB variable and export it to R.
     putRdata('NMJ_data', NMJ_data)
     putRdata('col_num', col_num);       
     % Run a simple R command using the data
     beta_mod = evalR('betareg(NMJ_data[col_num] ~ NMJ_data$Genotype)');
     beta_AIC = evalR('AIC(beta_mod)');
     getRdata('beta_mod');
     getRdata('beta_AIC');
     closeR
%
%       % Run a series of commands and import the result into MATLAB.
%       evalR('b <- a^2');
%       evalR('c <- b + 1');
%       getRdata('c')
%       % Close the connection.
%       closeR;
end

%find proper distribution of data based on minimum AICc and save as
%variable data_dist
%print results from fitglm model of selected best-fit distribution
[row, col] = find(AIC_vec == min(AIC_vec)); %#ok<*ASGLU>
if col == 1
    data_dist = ('Normal');
    data_mod = norm_mod;
elseif col == 2
    data_dist = ('Gamma');
    data_mod = gam_mod;
elseif col == 3
    data_dist = ('Lognormal');
    data_mod = log_mod;
elseif col == 4
    data_dist = ('Poisson');
    data_mod = pois_mod;
else
    data_dist = ('Unknown');
end
disp(data_dist);
disp(data_mod);
p_val = data_mod.Coefficients.pValue(2);
disp(p_val);
if p_val <= 0.05
    data_signif = true;
else
    data_signif = false;
end
end

