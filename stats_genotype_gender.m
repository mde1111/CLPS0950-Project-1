function [NMJ_table] = stats_genotype_gender(NMJ_data, gender, output_name)
%NMJ_GENOTYPE_STATS Finds distribution and runs stats on NMJ
%morphology data, returns table with results of generalized linear model
%statistical analysis
%Input: NMJ_data = data table to analyze;
    %gender = true if data includes M and F data, otherwise false
    %output_name = string in single quote for desired filename
%Output: NMJ_table, includes distribution, signficance by genotype, and
    %p-values from glm
    %saved in current directory under output_name as csv file
% Written by Madison Ewing on 03.02.21

%sets columns from data table want to analyze
col_nums = [2:8, 14:18];

%create empty vectors to populate for table
measurement_name = [];
data_significance = [];
data_distribution = [];
genotype_p_value = [];

if ~gender
    %for loop to run through analysis for each column in col_nums by
    %genotype only
    for jj = col_nums
        
        %extract measurement names for table and set model for glm
        col_string = (NMJ_data.Properties.VariableNames(jj));
        col_name = char(NMJ_data.Properties.VariableNames(jj));
        measurement_name = [measurement_name; col_string];
        geno_var = {' ~ Genotype'};
        mod_cell = strcat(col_name, geno_var);
        mod_spec = char(mod_cell);
        
        %fit generalized linear model with most likely possible 
        %distributions - normal, gamma,lognormal, poisson, beta
        modelspec = (mod_spec);
        AIC_vec = [];
        norm_mod = fitglm(NMJ_data, modelspec, 'Distribution', 'normal');
        AIC_vec = [AIC_vec, norm_mod.ModelCriterion.AICc];
        gam_mod = fitglm(NMJ_data, modelspec, 'Distribution', 'gamma');
        AIC_vec = [AIC_vec, gam_mod.ModelCriterion.AICc];
        log_mod = fitglm(NMJ_data, modelspec, 'Distribution', 'normal','link','log');
        AIC_vec = [AIC_vec, log_mod.ModelCriterion.AICc];
        pois_mod = fitglm(NMJ_data, modelspec, 'Distribution', 'poisson');
        AIC_vec = [AIC_vec, pois_mod.ModelCriterion.AICc];
        beta_mod = fitglm(NMJ_data, modelspec, 'link', 'logit');
        AIC_vec = [AIC_vec, beta_mod.ModelCriterion.AICc];

        %find and save best distribution of data based on minimum AICc
        [row, col] = find(AIC_vec == min(AIC_vec)); %#ok<ASGLU>
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
        elseif col == 5
            data_dist = ("Beta");
            data_mod = beta_mod;
        else
            data_dist = ("Unknown");
        end
        
        %create vector of distribution and p values to populate table
        data_distribution = [data_distribution; data_dist];
        geno_p_val = data_mod.Coefficients.pValue(2);
        genotype_p_value = [genotype_p_value; geno_p_val];
    
        %assigns boolean variable to signif for each column analyzed,
        %where true = statistically signficant difference by genotype
        if geno_p_val <= 0.05
            signif = true;
        else
            signif = false;
        end
        %vector of signficance for output table
        data_significance = [data_significance; signif];
    end
%save table of genotype results as output
NMJ_table = table(measurement_name, data_distribution, data_significance, genotype_p_value);

else
    %if input data needs tested by genotype and gender
    
    %empty vectors for additional p values with gender analysis
    gender_p_value = [];
    interaction_p_value = [];
    
    %for loop to run through analysis for each column in col_nums
    for jj = col_nums
        
        %extract measurement names for table and set model for glm
        col_string = NMJ_data.Properties.VariableNames(jj);
        col_name = char(NMJ_data.Properties.VariableNames(jj));
        measurement_name = [measurement_name; col_string];
        geno_var = {' ~ Genotype * Gender'};
        mod_cell = strcat(col_name, geno_var);
        mod_spec = char(mod_cell);
        
        %Find and save best fit generalized linear model with likely 
        %distributions - normal, gamma,lognormal, poisson
        modelspec = (mod_spec);
        AIC_vec = [];
        norm_mod = fitglm(NMJ_data, modelspec, 'Distribution', 'normal');
        AIC_vec = [AIC_vec, norm_mod.ModelCriterion.AICc];
        gam_mod = fitglm(NMJ_data, modelspec, 'Distribution', 'gamma');
        AIC_vec = [AIC_vec, gam_mod.ModelCriterion.AICc];
        log_mod = fitglm(NMJ_data, modelspec, 'Distribution', 'normal','link','log');
        AIC_vec = [AIC_vec, log_mod.ModelCriterion.AICc];
        pois_mod = fitglm(NMJ_data, modelspec, 'Distribution', 'poisson');
        AIC_vec = [AIC_vec, pois_mod.ModelCriterion.AICc];
        beta_mod = fitglm(NMJ_data, modelspec, 'link', 'logit');
        AIC_vec = [AIC_vec, beta_mod.ModelCriterion.AICc];
        if jj == 15
        disp(AIC_vec);
        end

        %find and save best fit distribution based on minimum AICc
        [row, col] = find(AIC_vec == min(AIC_vec));%#ok<ASGLU>
        
        %fix bug for if tie AIC values
        if length(col) > 1
            col = col(1,1);
        end
        
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
        elseif col == 5
            data_dist = ("Beta");
            data_mod = beta_mod;
        else
            data_dist = ("Unknown");
        end
        
        %create vectors of distribution and p values to populate table
        data_distribution = [data_distribution; data_dist];
        geno_p_val = data_mod.Coefficients.pValue(2);
        genotype_p_value = [genotype_p_value; geno_p_val];
        gend_p_val = data_mod.Coefficients.pValue(3);
        gender_p_value = [gender_p_value; gend_p_val];
        inter_p_val = data_mod.Coefficients.pValue(4);
        interaction_p_value = [interaction_p_value; inter_p_val];
    
        %assigns boolean variable to data_signif for each column analyzed,
        %where true = statistically signficant difference by genotype
        if geno_p_val <= 0.05
            signif = true;
        else
            signif = false;
        end
        data_significance = [data_significance; signif]; %#ok<*AGROW>
    end
    
%save table of genotype and gender results as output of function
NMJ_table = table(measurement_name, data_distribution, data_significance, genotype_p_value, gender_p_value, interaction_p_value);
end

%save table in current directory under chosen input name
table_file = strcat(output_name, '.csv');
table_name = char(table_file);
writetable(NMJ_table,table_name);
end
