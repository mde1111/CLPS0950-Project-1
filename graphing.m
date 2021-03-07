%should I also add the option of view all v chose your own?

%ask which muscle they would like to view the data and read data for that muscle 
muscle = input('Which muscle (STM, SOL, EDL) data are you interested in?');

if strcmp(muscle,'STM')
    x = input('Would you like to analyze this data at a "specific time interval" or "over time?"');
    if strcmp(x,'over time')
        a = monthSTMdata;
        b = monthSTMdata1;
        c = P14STMdata;
        d = P21STMdata;
        e = P30STMdata;
        f = yearSTMdata;
        xvar = [14, 21, 30, 90, 420, 720];
        disp('For the following question, type one of the following options:')
        disp('nerve terminal perimeter, nerve terminal area, total length of branches, average length of branches, complexity, AChR perimeter, AChR area, area of synaptic contactum, overlap, manual end plate area, manual compactness, fragmentation')
        yvar = input('Which variable data would you like to see?');
        if strcmp(yvar, 'nerve terminal perimeter')
            n = 2;
        elseif strcmp(yvar, 'nerve terminal area')
            n = 3;
        elseif strcmp(yvar,'total length of branches')
            n = 4;
        elseif strcmp(yvar, 'average length of branches')
            n = 5;
        elseif strcmp(yvar, 'complexity')
            n = 6;
        elseif strcmp(yvar,'AChR perimeter' )
            n = 7;
        elseif strcmp(yvar, 'AChR area')
            n = 8;
        elseif strcmp(yvar, 'area of synaptic contact')
            n = 14;
        elseif strcmp(yvar, 'overlap' )
            n = 15;
        elseif strcmp(yvar,'manual end plate data' )
            n = 16;
        elseif strcmp(yvar, 'manual compactness')
            n = 17;
        elseif strcmp(yvar, 'fragmentation')
            n = 18;
        else
        disp('Invalid entry. Please try again.')
    end 
        y1 = readtable(a(:,n));
        y2 = readtable(b(:,n));
        y3 = readtable(c(:,n));
        y4 = readtable(d(:,n));
        y5 = readtable(e(:,n));
        y6 = readtable(f(:,n));
        gtype = input('Would you like to see the results in a scatterplot or line graph?');
        if strcmp(gtype, 'scatterplot')
            scatter(xvar,y1,xvar,y2,xvar,y3,xvar,y4,xvar,y5,xvar,y6);
        else
            plot(xvar,y1,xvar,y2,xvar,y3,xvar,y4,xvar,y5,xvar,y6); 
        end
        %exit script until the part where it ask to view another graph 
    elseif strcmp(x, 'specific time interval')
        xvar = [HOM, WT];
        time = input('Would you like to analyze data at 14 days, 21 days, 1 month, 3 months, 14 months, or 2 years?');
            if strcmp(time, '14 days')
                table = P14STMdata;
                %add option of M/F or WT/HOM
                disp('For this time interval we have male and female data.')
                m = input('Would you like to plot based on "gender" or "genotype"?');
                    if strcmp(m,'gender')
                        xvar = [M, F];
                        %code to get data for male into M and female into F
                    end 
            elseif strcmp(time, '21 days')
                table = P21STMdata;
                %add option of M/F or WT/HOM
                 disp('For this time interval we have male and female data.')
                m = input('Would you like to plot based on "gender" or "genotype"?');
                   if strcmp(m,'gender')
                   %code to get data for male into M and female into F
                       xvar = [M, F];
                    end
            elseif strcmp(time, '1 month')
                table = P30STMdata;
            elseif strcmp(time, '3 months')
                readtable(monthSTMdata)
                %add option of M/F or WT/HOM
                 disp('For this time interval we have male and female data.')
                m = input('Would you like to plot based on "gender" or "genotype"?');
                   if strcmp(m,'gender')
                       xvar = [M, F];
                   %code to get data for male into M and female into F
                    end
            elseif strcmp(time, '14 months')
                table = monthSTMdata1;
            elseif strcmp(time, '2 years')
                table = yearSTMdata;
            else
                disp('Invalid entry. Please enter valid entry.')
            end
    else 
        disp('Invalid entry. Please enter a valid entry.')
    end
            
    
elseif strcmp(muscle,'SOL')
    table = monthSOLdata;
    xvar = [HOM, WT];
    
elseif strcmp(muscle,'EDL')
    table = monthEDLdata;
    xvar = [HOM, WT];
else 
    disp('Invalid entry. Please enter a valid muscle name.')
end


% ask for y variable
disp('For the following question, type one of the following options:')
disp('nerve terminal perimeter, nerve terminal area, total length of branches, average length of branches, complexity, AChR perimeter, AChR area, area of synaptic contactum, overlap, manual end plate area, manual compactness, fragmentation')
yvar = input('Which varibale data would you like to see?');
yname = yvar;
    if strcmp(yvar, 'nerve terminal perimeter')
        yvar = readtable(table(:,2));
    elseif strcmp(yvar, 'nerve terminal area')
        yvar = readtable(table(:,3));
    elseif strcmp(yvar,'total length of branches')
        yvar = readtable(table(:,4));
    elseif strcmp(yvar, 'average length of branches')
        yvar = readtable(table(:,5));
    elseif strcmp(yvar, 'complexity')
        yvar = readtable(table(:,6));
    elseif strcmp(yvar,'AChR perimeter' )
        yvar = readtable(table(:,7));
    elseif strcmp(yvar, 'AChR area')
        yvar = readtable(table(:,8));
    elseif strcmp(yvar, 'area of synaptic contact')
        yvar = readtable(table(:,14));
    elseif strcmp(yvar, 'overlap' )
        yvar = readtable(table(:,15));
    elseif strcmp(yvar,'manual end plate data' )
        yvar = readtable(table(:,16));
    elseif strcmp(yvar, 'manual compactness')
        yvar = readtable(table(:,17));
    elseif strcmp(yvar, 'fragmentation')
        yvar = readtable(table(:,18));
    else
        disp('Invalid entry. Please try again.')
    end       

%determine graphtype
disp('For the following question, type one of the following options: bar, scatterplot')
graphtype = input('What type of graph would you like?');

if strcmp(graphytype,'bar')
    f1 = figure;
    bar(xvar,yvar,0.5)
    xlabel('genotype')
    ylabel(yname)
elseif strcmp(graphtype,'scatterplot')
    f1 = figure;
    scatter(xvar,yvar)
    xlabel('genotype')
    ylabel(yname)
else 
    disp('Invalid entry, please try again.')
end

%to view additional graphs
another = input('Would you like to request an additional graph?');
if strcmp(another,'yes')
    f2 = figure;
    %ask questions again
elseif strcmp(another,'no')
    disp('Hope this helped!')
else 
    disp('Invalid entry. Please enter a valid answer.')
end




