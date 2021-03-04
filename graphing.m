%Graph of results - dotplots and/or density curves of most measurements

%Graph across lifespan - graph to look at how measurements change with age

graphs = figure;

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