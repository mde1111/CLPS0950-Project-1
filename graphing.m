%should I also add the option of view all v chose your own?

%ask which muscle they would like to view the data and read data for that muscle 
muscle = input('Which muscle (STM, SOL, EDL) data are you interested in?')

if strcmp(muscle,'STM')
    readtable(monthSTMdata);
    readtable(monthSTMdata1);
    readtable(P14STMdata);
    readtable(P21STMdata);
    readtable(P30STMdata);
    readtable(yearSTMdata);
    
elseif strcmp(muscle,'SOL')
    readtable(monthSOLdata);
    
elseif strcmp(muscle,'EDL')
    readtable(monthSOLdata);
    
else 
    disp('Invalid entry. Please enter a valid muscle name.')
    muscle = input('Which muscle (STM, SOL, EDL) data are you interested in?')
end


% ask which x and y variable they would like to see
disp('For the following question, type one of the following options:')
xvar = input('What would you like the x variable to be?');
        
disp('For the following question, type one of the following options:')
yvar = input('What you you like the y varibale to be');

%determine graphtype
disp('For the following question, type one of the following options: bar, scatterplot')
graphtype = input('What type of graph would you like?');

if strcmp(graphytype,'bar')
    bar(xvar,yvar,0.5)
elseif strcmp(graphtype,'scatterplot')
    scatter(xvar,yvar)
else 
    disp('Invalid entry, please try again.')
end

%to viee additional graphs, should  I use hold on or create subplot?
another = input('Would you like to request an additional graph?');
if strcmp(another,'yes')
    %ask questions again
elseif strcmp(another,'no')
    plot(xvar,yvar)
else 
    disp('Invalid entry. Please enter a valid answer')
end




