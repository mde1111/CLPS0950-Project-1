%stats_test
%Data analysis test script
%To test how to perform stats in MATLAB before writing function

%First need to import data
needed_data = [2:8,14:18];
disp(needed_data);

mean_col = [];
med_col = [];
std_col = [];

for ii = needed_data
    
%basic stats on data - mean, median, standard deviation
mean_col = [mean_col, mean(needed_data,1);
med_col = median(needed_data);
std_col = std(needed_data);
end

for ii = 2:length(needed_data)
end