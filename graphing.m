%should I also add the option of view all v chose your own?

%ask which muscle they would like to view the data and read data for that muscle 
muscle = input('Which muscle (STM, SOL, EDL) data are you interested in?');

if strcmp(muscle,'STM')
    x = input('Would you like to analyze this data at a "specific time interval" or "over time?"');
    if strcmp(x,'over time')
        readtable(monthSTMdata);
        readtable(monthSTMdata1);
        readtable(P14STMdata);
        readtable(P21STMdata);
        readtable(P30STMdata);
        readtable(yearSTMdata);
        xvar = [14, 21, 30, 90, 420, 720];
        
    elseif strcmp(x, 'specific time interval')
        xvar = [HOM, WT]
        time = input('Would you like to analyze data at 14 days, 21 days, 1 month, 3 months, 14 months, or 2 years?');
            if strcmp(time, '14 days')
                readtable(P14STMdata)
                %add option of M/F or WT/HOM
            elseif strcmp(time, '21 days')
                readtable(P21STMdata)
                %add option of M/F or WT/HOM
            elseif strcmp(time, '1 month')
                readtable(P30STMdata)
            elseif strcmp(time, '3 months')
                readtable(monthSTMdata)
                %add option of M/F or WT/HOM
            elseif strcmp(time, '14 months')
                readtable(monthSTMdata1)
            elseif strcmp(time, '2 years')
                readtable(yearSTMdata)
            else
                disp('Invalid entry. Please enter valid entry.')
            end
    else 
        disp('Invalid entry. Please enter a valid entry.')
    end
            
    
elseif strcmp(muscle,'SOL')
    readtable(monthSOLdata);
    xvar = [HOM, WT]
    
elseif strcmp(muscle,'EDL')
    readtable(monthSOLdata);
    xvar = [HOM, WT]
else 
    disp('Invalid entry. Please enter a valid muscle name.')
    muscle = input('Which muscle (STM, SOL, EDL) data are you interested in?');
end


% ask for y variable
disp('For the following question, type one of the following options:')
disp('nerve terminal perimeter, nerve terminal area, total length of branches, average length of branches, complexity, AChR perimeter, AChR area, area of synaptic contactum, overlap, manual end plate area, manual compactness, fragmentation')
yvar = input('Which varibale data would you like to see?');
yname = yvar
    if strcmp(yvar, 'nerve terminal perimeter')
        %yvar = data from column 2 
    end       

%determine graphtype
disp('For the following question, type one of the following options: bar, scatterplot')
graphtype = input('What type of graph would you like?');

if strcmp(graphytype,'bar')
    bar(xvar,yvar,0.5)
    xlabel('genotype')
    ylabel(yname)
elseif strcmp(graphtype,'scatterplot')
    scatter(xvar,yvar)
    xlabel('genotype')
    ylabel(yname)
else 
    disp('Invalid entry, please try again.')
end

%to view additional graphs, should  I use hold on or create subplot?
another = input('Would you like to request an additional graph?');
if strcmp(another,'yes')
    
    %ask questions again
elseif strcmp(another,'no')
    disp('Hope this helped!')
else 
    disp('Invalid entry. Please enter a valid answer.')
end




