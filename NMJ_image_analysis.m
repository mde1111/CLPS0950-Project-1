function [morph_table] = NMJ_image_analysis(NMJ_directory, file_output)
%NMJ_IMAGE_ANALYSIS Takes flattened maximum Z projection of 2 channel NMJ
%iamges; calculates morphological data and outputs results in table
%Inputs:
    %NMJ_directory = choose folder/directory to analyze NMJs from; will
        %analyze any tiff files in that folder and its subfolders
    %file_output = string of name to save file as csv
%Created by Madison Ewing 03.05.21

%morphological measurements used to analyze NMJs adapted from NMJ morph
%macro workflow (Jones et al. 2016), which can be found at this link:
%https://royalsocietypublishing.org/doi/10.1098/rsob.160240#RSOB160240C32

%time to run = approx. 6 seconds/NMJ (compared to 3-5 minutes manually)

%factor for conversion from pixels to micrometers (um)
pixels_per_um = 10.91;

%find tiff NMJ images in current folder and subfolders to analyze
NMJFileNames = {};
fileType = fullfile(NMJ_directory, '**/*.tif');
NMJFiles = dir(fileType);
for n = 1 : length(NMJFiles)
    baseFileName = NMJFiles(n).name;
    fullFileName = fullfile(NMJFiles(n).folder, baseFileName);
    NMJFileNames = [NMJFileNames; fullFileName];
end

%vectors of zeros to popoulate for output table
start_vec = zeros(length(NMJFileNames),1);
NerveTerminalPerimeterum = start_vec;
NerveTerminalAreaum2 = start_vec;
TotalLengthOfBranchesum = start_vec;
AverageLengthOfBranchesum = start_vec;
Complexity = start_vec;
AChRPerimeterum = start_vec;
AChRAreaum2 = start_vec;
AreaOfSynapticContactum2 = start_vec;
Overlap = start_vec;
ManualEndplateAreaum2 = start_vec;
ManualCompactness = start_vec;
Fragmentation = start_vec;

%loop to run through analysis on each tiff file found
for c = 1:length(NMJFileNames)
    %load image, which has presynaptic (2) and postsynaptic (1) channel
    axon_terminal = imread(NMJFileNames{c},2);
    muscle_endplate = imread(NMJFileNames{c},1);

    %threshold, filter, and make binary nerve terminal
    axon_thresh = graythresh(axon_terminal);
    axon_med = medfilt2(axon_terminal);
    bw_axon = imbinarize(axon_med, axon_thresh);
    axon_filt = medfilt2(bw_axon);
    axon_filt_2 = wiener2(axon_filt,[5 5]);

    %find and save area of axon terminal
    axon_area = bwarea(axon_filt_2);
    NerveTerminalAreaum2 (c) = axon_area / (pixels_per_um^2);

    %find and save perimeter of axon terminal
    axon_perim_img = bwperim(axon_filt_2);
    axon_perim = sum(axon_perim_img(:));
    NerveTerminalPerimeterum (c) = axon_perim / pixels_per_um;

    %skeletonize axon terminal and perform branching analysis
    axon_skel = bwskel(axon_filt_2);
    count_2 = 0;
    count_4 = 0;
    count_5 = 0;

    %check binary connectivity of pixels in skeletonized image
    %based on number of filled pixels in 8 pixels surrounding
    for ii = 2:size(axon_skel,1)-1
        for jj = 2:size(axon_skel,2)-1
            pixel_check = axon_skel(jj-1:jj+1, ii-1:ii+1);
            pixel_connect = sum(pixel_check(:));
            if axon_skel(jj,ii) == 1
                if pixel_connect == 2
                    count_2 = count_2 + 1;
                elseif pixel_connect == 4
                    count_4 = count_4 + 1;
                elseif pixel_connect == 5
                    count_5 = count_5 + 1;
                end
            end
        end
    end

    %compute branching values from connectivity counts
    branch_point_num = count_4 + count_5;
    TotalLengthOfBranchesum (c) = sum(axon_skel(:)) / pixels_per_um;

    AverageLengthOfBranchesum (c) = TotalLengthOfBranchesum (c) / count_2;

    Complexity (c) = log10(count_2 * branch_point_num * TotalLengthOfBranchesum (c));

    %threshold, filter, and make binary muscle endplate
    endplate_thresh = graythresh(muscle_endplate);
    endplate_med = medfilt2(muscle_endplate);
    bw_endplate = imbinarize(endplate_med, endplate_thresh);
    endplate_filt = medfilt2(bw_endplate);
    endplate_filt_2 = wiener2(endplate_filt,[5 5]);

    %find and save area of AChRs
    AChR_area = bwarea(endplate_filt_2);
    AChRAreaum2 (c) = AChR_area / (pixels_per_um^2);

    %find and save perimeter of AChRs
    AChR_perim_img = bwperim(endplate_filt_2);
    AChR_perim = sum(AChR_perim_img(:));
    AChRPerimeterum (c) = AChR_perim / pixels_per_um;

    %create smooth endplate around AChR staining
    structure = strel('disk',50);
    endplate_round = imclose(endplate_filt_2,structure);
    endplate_fill = imfill(endplate_round, 'holes');
    ManualEndplateAreaum2 (c) = bwarea(endplate_fill) / (pixels_per_um^2);
    ManualCompactness (c) = AChRAreaum2 (c) / ManualEndplateAreaum2 (c);

    %area of synaptic contact and overlap
    syn_contact = 0;
    for ii = 1:size(endplate_filt_2,1)
        for jj = 1:size(endplate_filt_2,2)
            if axon_filt_2(jj,ii) == 1 && endplate_filt_2(jj,ii) == 1
                syn_contact = syn_contact + 1;
            end
        end
    end
    AreaOfSynapticContactum2 (c) = syn_contact / (pixels_per_um^2);
    Overlap (c) = AreaOfSynapticContactum2 (c) / AChRAreaum2 (c);

    %fragmentation of AChR clusters
    AChR_frag = bwconncomp(endplate_filt_2);
    Fragmentation (c) = AChR_frag.NumObjects;
end

%Save results into output table
morph_table = table(NMJFileNames,NerveTerminalPerimeterum, NerveTerminalAreaum2, TotalLengthOfBranchesum, AverageLengthOfBranchesum, Complexity, AChRPerimeterum, AChRAreaum2, AreaOfSynapticContactum2, Overlap, ManualEndplateAreaum2, ManualCompactness, Fragmentation);
table_name = strcat(file_output, '.csv');
file_name = char(table_name);
writetable(morph_table,file_name);
end

