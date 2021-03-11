Statistical Analysis and Graphing of Biological Data

Created by K2M

Katie Yetter, Maria Rodriguez, and Madison Ewing

For CLPS 0950 Project 1

The overall goal of this repository is to aid in visualization, image analysis, statistical analysis, and graphing of biological data for morphological data gathered through immunostaining of neuromuscular junctions.

Research Question: What affect does deletion of the Ig3 domain of MuSK have on morphology of the mouse neuromuscular junction?

Components of Project:

1. Animation.m

    Written by Katie Yetter
    
    Debugged by Maria Rodriguez (debugging time = 1hr)
    
    Time = 35 hours
    
    Interactive animation script showing pre- and postsynaptic images taken from wild type and deltaIg3-MuSK (HOM) mice
    
    Uses psychtoolbox to display images

2. NMJ_image_analysis.m

    Written by Madison Ewing
    
    Debugged by Katie Yetter (debugging time = 1 hour)
    
    Time = 17.5 hours

    Function designed to run morphological analysis on tiff images of NMJs (according to NMJ-morph macro workflow) - run time = 6 sec/NMJ.
    
    Input directory that contains tiff images and desired name of output file.
    
    Outputs presynaptic and postsynaptic areas and perimeters, area of synaptic contact, overlap, average and total nerve terminal branch length, nerve terminal complexity, endplate area, compactness, and postsyanptic fragmentation; saves as csv file.
    
3. stats_genotype_gender.m

    Written by Madison Ewing
    
    Debbuged by Katie Yetter (debugging time = 1 hour)
    
    Time = 11.5 hours

    Function that runs statistical analysis on NMJ morphological data; picks best fit distribution and runs generalized linear model by either genotype or genotype+gender.
    
    Input table containing NMJ data (e.g. P21 STM data.csv contained in repository) and desired name of output file.
    
    Outputs signficance by genotype, best fit distribution, and p values for each morphological measurement; saves as csv file.
    
4. graphing.m

    Written by Maria Rodriguez
    
    Debugged by Madison Ewing (debugging time = 1.0 hours)
    
    Time = 17 hours
    
    Interactive graphing script that graphs NMJ morphological data according to specifications by the user.
    
    
