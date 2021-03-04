% ask which x and which variable they would like to see
disp('For the following question, input one of the following options:')
xvar = input('What would you like the x variable to be?')
 
disp('For the following question, input one of the following options:')
yvar = input('What you you like the y varibale to be')

disp('For the following question, input one of the following options: bar, scatter')
graphtype = input('What type of graph would you like?')

another = input('Would you like to request an additional graph?')
%if another = 'yes'
    %ask questions again
    %else proceed to display graph 
    

    
%Graph of results - dotplots and/or density curves of most measurements
scatter(x,y)
title()
xlabel()
ylabel()


%Graph across lifespan - graph to look at how measurements change with age

graphs = figure;
xlsread(monthSTMdata)
x = importedxdata;
y = importedydata;

plot(x,y)
subplots(1,3,1)
xlabel('name of variable')
ylabel('name of variable')
title('x v y')

plot(x,y,'g')

plot(x,y)
subplots(1,3,2)
xlabel('name of variable')
ylabel('name of variable')
title('x v y')

subplots(1,3,3)
xlabel('name of variable')
ylabel('name of variable')
title('x v y')

