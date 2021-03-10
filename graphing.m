%should I also add the option of view all v chose your own?
run = true;
skipy = true;
next = true;
%ask which muscle they would like to view the data and read data for that muscle 
while run == true 
muscle = input('Which muscle (STM, SOL, EDL) data are you interested in?','s');

if strcmp(muscle,'STM')
        disp('For the following question, type one of the following options:')
        disp('nerve terminal perimeter, nerve terminal area, total length of branches, average length of branches, complexity, AChR perimeter, AChR area, area of synaptic contactum, overlap, manual end plate area, manual compactness, fragmentation')
        yvar = input('Which variable data would you like to see?','s');
        yname = yvar;
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
        end 
    x = input('Would you like to analyze this data at a "specific time interval" or "over time?"','s');
    if strcmp(x,'over time')
        xvar = [14, 21, 30, 90, 420, 720];
        yvar = [];
        a = monthSTMdata;
            a = table2cell(a(:,n));
            [r,s] = size(a);
            values = [];
            for ii = 1:r
            values = [values a{ii}(:)];
            end
            va = values;
            va = mean(va);
            yvar = [yvar va];
        b = monthSTMdata1;
            b = table2cell(b(:,n));
            [r,s] = size(b);
            values = [];
            for ii = 1:r
            values = [values b{ii}(:)];
            end
            vb = values;
            vb = mean(vb);
            yvar = [yvar vb];
        c = P14STMdata;
            c = table2cell(c(:,n));
            [r,s] = size(c);
            values = [];
            for ii = 1:r
            values = [values c{ii}(:)];
            end
            vc = values;
            vc = mean(vc);
            yvar = [yvar vc];
        d = P21STMdata;
            d = table2cell(d(:,n));
            [r,s] = size(d);
            values = [];
            for ii = 1:r
            values = [values d{ii}(:)];
            end
            vd = values;
            vd = mean(vd);
            yvar = [yvar vd];
        e = P30STMdata;
            e = table2cell(e(:,n));
            [r,s] = size(e);
            values = [];
            for ii = 1:r
            values = [values e{ii}(:)];
            end
            ve = values;
            ve = mean(ve);
            yvar = [yvar ve];
        f = yearSTMdata;
            f = table2cell(f(:,n));
            [r,s] = size(f);
            values = [];
            for ii = 1:r
            values = [values f{ii}(:)];
            end
            vf = values;
            vf = mean(vf);
            yvar = [yvar vf];
        gtype = input('Would you like to see the results in a line or bar graph?','s');
        if strcmp(gtype, 'line')
            f0 = figure
            plot(yvar)
            xticks(xvar)
            xticklabels({'14','21','30','90','420','720'})
            xlabel('time in days')
            ylabel(yname)
            next = false;
        else
            f0 = figure
            bar(yvar)
            xticks(xvar)
            xticklabels({'14','21','30','90','420','720'})
            xlabel('time in days')
            ylabel(yname)
            next = false;
        end
        next = false;
    elseif strcmp(x, 'specific time interval') 
        time = input('Would you like to analyze data at 14 days, 21 days, 1 month, 3 months, 14 months, or 2 years?','s');
            if strcmp(time, '14 days')
                table = P14STMdata;
                type = P14STMdata;
                t = P14STMdata;
                [r,s] = size(table);
                %add option of M/F or WT/HOM
                disp('For this time interval we have male and female data.')
                m = input('Would you like to plot based on "gender" or "genotype"?','s');
                    if strcmp(m,'gender')
                        %code to get data for male into M and female into F
                        type = table2cell(table(:,21))
                        tp = P14STMdata;
                        disp(type)
                        gM = [];
                        gF =[];
                        F = 0;
                        M = 0;
                        for ii = 1:r
                            A = type{ii}
                            A = string(A)
                            if strcmp(A,'M')
                                M = M +1;
                                t = table2cell(tp(ii,n));
                                gM = [gM, t];
                            else
                                F = F+1;
                                t = table2cell(tp(ii,n));
                                gF = [gF, t];
                            end
                        end

                    gtype = input('Would you like to see the results in a "line" or "bar" graph?','s');
                              gFp = [];
                              gMp = [];
                              for jj = 1:F
                                    gFp = [gFp gF{jj}(:)];
                              end

                              for kk = 1:M
                                    gMp = [gMp gM{kk}(:)];
                              end
                            if strcmp(gtype, 'line')
                                   f0 = figure
                                    plot(gFp)
                                    hold on
                                    plot(gMp)
                                    ylabel(yname)
                                    next = false
                            elseif strcmp(gtype, 'bar')
                                    f0 = figure
                                    gMp = mean(gMp);
                                    gFp = mean(gFp);
                                    y = [gMp, gFp];
                                    bar(y)
                                    xlabel('gender')
                                    xticklabels({'M','F'})
                                    ylabel(yname)
                                    next = false
                            end
                    else 
                        yvar = n;
                        skipy = false;
                    end

            elseif strcmp(time, '21 days')
                table = P21STMdata;
                type = P21STMdata;
                t = P21STMdata;
                [r,s] = size(table);
                %add option of M/F or WT/HOM
                disp('For this time interval we have male and female data.')
                m = input('Would you like to plot based on "gender" or "genotype"?','s');
                    if strcmp(m,'gender')
                        %code to get data for male into M and female into F
                        type = table2cell(table(:,21))
                        tp = P21STMdata;
                        disp(type)
                        gM = [];
                        gF =[];
                        M = 0;
                        F = 0;
                        for ii = 1:r
                            A = type{ii}
                            A = string(A)
                            if strcmp(A,'M')
                                M = M +1;
                                t = table2cell(tp(ii,n));
                                gM = [gM, t];
                            else
                                F = F+1;
                                t = table2cell(tp(ii,n));
                                gF = [gF, t];
                            end
                        end

                            gtype = input('Would you like to see the results in a "line" or "bar" graph?','s');
                              gFp = [];
                              gMp = [];
                              for jj = 1:F
                                    gFp = [gFp gF{jj}(:)];
                              end

                              for kk = 1:M
                                    gMp = [gMp gM{kk}(:)];
                              end
                            if strcmp(gtype, 'line')
                                   f0 = figure
                                    plot(gFp)
                                    hold on
                                    plot(gMp) 
                                   next = false;
                            elseif strcmp(gtype, 'bar')
                                    f0 = figure
                                    gMp = mean(gMp);
                                    gFp = mean(gFp);
                                    y = [gMp, gFp];
                                    bar(y)
                                    xlabel('gender')
                                    xticklabels({'M','F'})
                                    ylabel(yname)
                                    next = false;
                            end
                    else
                        yvar = n;
                        skipy = false;
                    end
            elseif strcmp(time, '3 months')
                table = x3monthSTMdata2;
                type = x3monthSTMdata2;
                t = x3monthSTMdata2;
               [r,s] = size(table);
               %add option of M/F or WT/HOM
                disp('For this time interval we have male and female data.')
                m = input('Would you like to plot based on "gender" or "genotype"?','s');
                    if strcmp(m,'gender')
                        %code to get data for male into M and female into F
                        type = table2cell(table(:,21));
                        tp = P30STMdata;
                        disp(type);
                        gM = [];
                        gF =[];
                        F = 0;
                        M = 0;
                        for ii = 1:r
                            A = type{ii}
                            A = string(A)
                            if strcmp(A,'M')
                                M = M +1;
                                t = table2cell(tp(ii,n));
                                gM = [gM, t];
                            else
                                F = F+1;
                                t = table2cell(tp(ii,n));
                                gF = [gF, t];
                            end
                        end
                            gtype = input('Would you like to see the results in a "line" or "bar" graph?','s');
                              gFp = [];
                              gMp = [];
                              for jj = 1:F
                                    gFp = [gFp gF{jj}(:)];
                              end

                              for kk = 1:M
                                    gMp = [gMp gM{kk}(:)];
                              end
                            if strcmp(gtype, 'line')
                                   f0 = figure
                                    plot(gFp)
                                    hold on
                                    plot(gMp)    
                                    next = false;
                            elseif strcmp(gtype, 'bar')
                                    f0 = figure
                                    gMp = mean(gMp);
                                    gFp = mean(gFp);
                                    y = [gMp, gFp];
                                    bar(y)
                                    xlabel('gender')
                                    xticklabels({'M','F'})
                                    ylabel(yname)
                                    next = false;       
                            end
                    else
                        yvar = n;
                        skipy =  false;
                    end  
            elseif strcmp(time, '1 month')
                table = P30STMdata;
                type = P30STMdata;
                t = P30STMdata;
                yvar = n;
                next = true;
                skipy = false;
            elseif strcmp(time, '14 months')
                table = x14moSTMdata1;
                type = x14moSTMdata1;
                t = x14moSTMdata1;
                yvar = n;
                next = true;
                skipy = false;
            elseif strcmp(time, '2 years')
                table = yearSTMdata;
                type = yearSTMdata;
                t = yearSTMdata;
                yvar = n;
                next = true;
                skipy = false;
            else
                disp('Invalid entry. Please enter valid entry.')
            end
    else 
        disp('Invalid entry. Please enter a valid entry.')
        run = false;
            end
    
          
%from here down it's all good!    
    
elseif strcmp(muscle,'SOL')
    table = "D:\Users\mariarodriguez\MATLAB\projects\cs\monthSOLdata.csv";
    table = monthSOLdata;
    type = monthSOLdata;
    t = monthSOLdata;
    next = true;
    skipy = true;
    
elseif strcmp(muscle,'EDL')
    table = "D:\Users\mariarodriguez\MATLAB\projects\cs\monthEDLdata.csv";
    table = monthEDLdata;
    type = monthEDLdata;
    t = monthSOLdata;
    next = true;
    skipy = true;
else 
    disp('Invalid entry. Please enter a valid muscle name.')
    run = false;
end

while next == true
while skipy == true
% ask for y variable
disp('For the following question, type one of the following options:')
disp('nerve terminal perimeter, nerve terminal area, total length of branches, average length of branches, complexity, AChR perimeter, AChR area, area of synaptic contactum, overlap, manual end plate area, manual compactness, fragmentation')
yvar = input('Which varibale data would you like to see?','s');
yname = yvar;
    if strcmp(yvar, 'nerve terminal perimeter')
        yvar = 2;
    elseif strcmp(yvar, 'nerve terminal area')
        yvar = 3;
    elseif strcmp(yvar,'total length of branches')
        yvar = 4;
    elseif strcmp(yvar, 'average length of branches')
        yvar = 5;
    elseif strcmp(yvar, 'complexity')
        yvar = 6;
    elseif strcmp(yvar,'AChR perimeter' )
        yvar = 7;
    elseif strcmp(yvar, 'AChR area')
        yvar = 8;
    elseif strcmp(yvar, 'area of synaptic contact')
        yvar = 14;
    elseif strcmp(yvar, 'overlap' )
        yvar = 15;
    elseif strcmp(yvar,'manual end plate data' )
        yvar = 16;
    elseif strcmp(yvar, 'manual compactness')
        yvar = 17;
    elseif strcmp(yvar, 'fragmentation')
        yvar = 18;
    else
        disp('Invalid entry. Please try again.')
        run = false;
    end  
skipy = false;
end

%determine graphtype
disp('For the following question, type one of the following options: bar, line')
graphtype = input('What type of graph would you like?','s');
%variables to make plot code work, need to reset every new plot made
    [z,x] = size(table);
    type = table2cell(type(:,20));
    gen = [];
    gwt =[];
    hom =0;
    wt =0;
    %code to divide between HOM and WT
    for ii = 1:z
        A = type{ii};
        A = string(A);
        if strcmp(A,'HOM')
            hom = hom +1;
            t = table2cell(table(ii,yvar));
            gen = [gen, t];
        else
            wt = wt+1;
            t = table2cell(table(ii,yvar));
            gwt = [gwt, t];
        end
    end
    
if strcmp(graphtype,'bar')
    %plot WT Bar
    genp = [];
    for jj = 1:hom
    genp = [genp gen{jj}(:)];
    end
    f2 = figure
    genp = mean(genp);
    subplot(1,2,1)
    bar(genp)
    xlabel('HOM')
    ylabel(yname)
    
    %plot HOM Bar
    gwtp = [];
    for kk = 1:wt
    gwtp = [gwtp gwt{kk}(:)];
    end
    subplot(1,2,2)
    gwtp = mean(gwtp);
    bar(gwtp)
    xlabel('WT')
    ylabel(yname)
    
elseif strcmp(graphtype,'line')
    %plot WT Line
    for jj = 1:hom
    genp = [genp gen{jj}(:)];
    end
    f2 = figure
    subplot(1,2,1)
    plot(genp)
    xlabel('HOM')
    ylabel(yname)
    
    %plot HOM Line
    for kk = 1:wt
    gwtp = [gwtp gwt{kk}(:)];
    end
    subplot(1,2,2)
    plot(gwtp)
    xlabel('WT')
    ylabel(yname)

else 
    disp('Invalid entry, please try again.')
    run = false;
end
next = false;
%end for next
end

%to view additional graphs
another = input('Would you like to request an additional graph? (yes/no)','s');
if strcmp(another,'yes')
    run = true;
    next = true;
    skipy = true;
    %ask questions again
else
    disp('Hope this helps!')
    run = false;
end
end
