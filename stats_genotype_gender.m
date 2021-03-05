function [NMJ_table] = stats_genotype_gender(NMJ_data, gender)
%NMJ_GENOTYPE_STATS Find best fit distribution and runs stats on NMJ
%morphology data, prints output and signficance of generalized linear model
%with best fit distribution by genotype and gender
%Input: NMJ_data = data table to analyze; gender = true or false
%Output: data_signif = boolean vector of signficance by genotype
% Written by Madison Ewing on 03.02.21

%check AICc - if less than 2 different that normal, use normal distribution

%sets columns from data table want to analyze
col_nums = [2:8, 14:18];
name_vec = [];
data_signif = [];
dist_vec = [];
geno_pval_vec = [];

if ~gender
    %for loop to run through analysis for each column in col_nums by
    %genotype only
    for jj = col_nums
        col_string = (NMJ_data.Properties.VariableNames(jj));
        col_name = char(NMJ_data.Properties.VariableNames(jj));
        name_vec = [name_vec; col_string];
        geno_var = {' ~ Genotype'};
        mod_cell = strcat(col_name, geno_var);
        mod_spec = char(mod_cell);
        NMJ_log = NMJ_data;
        NMJ_log(1:end, col_name) = varfun(@log,NMJ_log,'InputVariables',col_name);
        
        if jj == 15 || jj == 17
            %specify beta distribution for overlap and compactness
            %need logit link in glm as approx. of beta, can't compare AICc
            %distribution known from testing glm with BetaReg package in R
            beta_mod = fitglm(NMJ_data, modelspec, 'link', 'logit');
            data_dist = ('Beta');
            data_mod = beta_mod;
            
        else
            %specify model (eventually use for loop to go through all columns?)
            %fit generalized linear model with possible distributions - normal, gamma,
            %lognormal, poisson
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

            %find proper distribution of data based on minimum AICc and save as
            %variable data_dist
            %print results from fitglm model of selected best-fit distribution
            [row, col] = find(AIC_vec == min(AIC_vec)); %#ok<*ASGLU>
            if col == 1
                data_dist = ("Normal");
                data_mod = norm_mod;
            elseif col == 2
                data_dist = ("Gamma");
                data_mod = gam_mod;
            elseif col == 3
                data_dist = ("Lognormal");
                data_mod = log_mod;
            elseif col == 4
                data_dist = ("Poisson");
                data_mod = pois_mod;
            else
                data_dist = ("Unknown");
            end
        end
        %disp(data_dist);
        %disp(data_mod);
        dist_vec = [dist_vec; data_dist];
        geno_p_val = data_mod.Coefficients.pValue(2);
        geno_pval_vec = [geno_pval_vec; geno_p_val];
        %disp(geno_p_val);
    
        %assigns boolean variable to data_signif for each column analyzed,
        %where true = statistically signficant difference by genotype
        if geno_p_val <= 0.05
            signif = true;
        else
            signif = false;
        end
    
        data_signif = [data_signif; signif];
    end
%save table of genotype results as output
NMJ_table = table(name_vec, dist_vec, data_signif, geno_pval_vec);

else
    gend_pval_vec = [];
    inter_pval_vec = [];
    %for loop to run through analysis for each column in col_nums
    for jj = col_nums
        col_string = NMJ_data.Properties.VariableNames(jj);
        col_name = char(NMJ_data.Properties.VariableNames(jj));
        name_vec = [name_vec; col_string];
        geno_var = {' ~ Genotype * Gender'};
        mod_cell = strcat(col_name, geno_var);
        mod_spec = char(mod_cell);
        NMJ_log = NMJ_data;
        NMJ_log(1:end, col_name) = varfun(@log,NMJ_log,'InputVariables',col_name);
        
        if jj == 15 || jj == 17
            %specify beta distribution for overlap and compactness
            %need logit link in glm, can't compare AICc
            %distribution known from testing glm with BetaReg package in R
            beta_mod = fitglm(NMJ_data, modelspec, 'link', 'logit');
            data_dist = ("Beta");
            data_mod = beta_mod;
            
        else
            %specify model (eventually use for loop to go through all columns?)
            %fit generalized linear model with possible distributions - normal, gamma,
            %lognormal, poisson
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

            %find proper distribution of data based on minimum AICc and save as
            %variable data_dist
            %print results from fitglm model of selected best-fit distribution
            [row, col] = find(AIC_vec == min(AIC_vec));
            if col == 1
                data_dist = ("Normal");
                data_mod = norm_mod;
            elseif col == 2
                data_dist = ("Gamma");
                data_mod = gam_mod;
            elseif col == 3
                data_dist = ("Lognormal");
                data_mod = log_mod;
            elseif col == 4
                data_dist = ("Poisson");
                data_mod = pois_mod;
            else
                data_dist = ("Unknown");
            end
        end
        %disp(data_dist);
        %disp(data_mod);
        dist_vec = [dist_vec; data_dist];
        geno_p_val = data_mod.Coefficients.pValue(2);
        geno_pval_vec = [geno_pval_vec; geno_p_val];
        %disp(geno_p_val);
        gend_p_val = data_mod.Coefficients.pValue(3);
        gend_pval_vec = [gend_pval_vec; gend_p_val];
        inter_p_val = data_mod.Coefficients.pValue(4);
        inter_pval_vec = [inter_pval_vec; inter_p_val];
    
        %assigns boolean variable to data_signif for each column analyzed,
        %where true = statistically signficant difference by genotype
        if geno_p_val <= 0.05
            signif = true;
        else
            signif = false;
        end
        data_signif = [data_signif; signif];
    end
    
%save table of genotype and gender results as output of function
NMJ_table = table(name_vec, dist_vec, data_signif, geno_pval_vec, gend_pval_vec, inter_pval_vec);
end