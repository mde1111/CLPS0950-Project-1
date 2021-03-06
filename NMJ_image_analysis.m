function [morph_table] = NMJ_image_analysis(NMJ_directory)
%NMJ_IMAGE_ANALYSIS Takes flattened maximum Z projection of 2 channel NMJ
%iamges (input as string vector of imported images); calculates morphological data and
%outputs results in table
%Created by Madison Ewing 03.05.21

%morphological measurements used to analyze NMJs adapted from NMJ morph
%macro workflow (Jones et al. 2016), which can be found at this link:
%https://royalsocietypublishing.org/doi/10.1098/rsob.160240#RSOB160240C32

%factor for conversion from pixels to micrometers (um)
pixels_per_um = 10.91;

%find tiff NMJ images in current folder to analyze
NMJFileNames = {};
fileType = fullfile(NMJ_directory, '**/*.tif');
NMJFiles = dir(fileType);
for n = 1 : length(NMJFiles)
    baseFileName = NMJFiles(n).name;
    fullFileName = fullfile(NMJFiles(n).folder, baseFileName);
    NMJFileNames = [NMJFileNames; fullFileName];
end
disp(NMJFileNames);

%empty vectors to popoulate for output table
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

for c = 1:length(NMJFileNames)
    %load image, which has presynaptic (1) and postsynaptic (2) channels
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
    axon_area_um2 = axon_area / (pixels_per_um^2);
    NerveTerminalAreaum2 (c) = axon_area_um2;

    %find and save perimeter of axon terminal
    axon_perim_img = bwperim(axon_filt_2);
    axon_perim = sum(axon_perim_img(:));
    axon_perim_um = axon_perim / pixels_per_um;
    NerveTerminalPerimeterum (c)= axon_perim_um;

    %skeletonize axon terminal and perform branching analysis
    axon_skel = bwskel(axon_filt_2);
    count_2 = 0;
    count_4 = 0;
    count_5 = 0;

    %check binary connectivity of pixels in skeletonized image
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
    total_branch_leng = sum(axon_skel(:)) / pixels_per_um;
    TotalLengthOfBranchesum (c) = total_branch_leng;

    avg_branch_leng = total_branch_leng / count_2;
    AverageLengthOfBranchesum (c) = avg_branch_leng;

    complex_val = log10(count_2 * branch_point_num * total_branch_leng);
    Complexity (c) = complex_val;

    %threshold, filter, and make binary muscle endplate
    endplate_thresh = graythresh(muscle_endplate);
    endplate_med = medfilt2(muscle_endplate);
    bw_endplate = imbinarize(endplate_med, endplate_thresh);
    endplate_filt = medfilt2(bw_endplate);
    endplate_filt_2 = wiener2(endplate_filt,[5 5]);

    %find and save area of AChRs
    AChR_area = bwarea(endplate_filt_2);
    AChR_area_um2 = AChR_area / (pixels_per_um^2);
    AChRAreaum2 (c) = AChR_area_um2;

    %find and save perimeter of AChRs
    AChR_perim_img = bwperim(endplate_filt_2);
    AChR_perim = sum(AChR_perim_img(:));
    AChR_perim_um = AChR_perim / pixels_per_um;
    AChRPerimeterum (c) = AChR_perim_um;

    %create smooth endplate around AChR staining
    structure = strel('disk',50);
    endplate_round = imclose(endplate_filt_2,structure);
    endplate_fill = imfill(endplate_round, 'holes');
    endplate_area_um2 = bwarea(endplate_fill) / (pixels_per_um^2);
    ManualEndplateAreaum2 (c) = endplate_area_um2;
    compactness = AChR_area_um2 / endplate_area_um2;
    ManualCompactness (c) = compactness;

    %area of synaptic contact and overlap
    syn_contact = 0;
    for ii = 1:size(endplate_filt_2,1)
        for jj = 1:size(endplate_filt_2,2)
            if axon_filt_2(jj,ii) == 1 && endplate_filt_2(jj,ii) == 1
                syn_contact = syn_contact + 1;
            end
        end
    end
    syn_contact_um2 = syn_contact / (pixels_per_um^2);
    AreaOfSynapticContactum2 (c) = syn_contact_um2;
    over_area = syn_contact_um2 / AChR_area_um2;
    Overlap (c) = over_area;

    %fragmentation of AChR clusters
    AChR_frag = bwconncomp(endplate_filt_2);
    frag_num = AChR_frag.NumObjects;
    Fragmentation (c) = frag_num;
end

%Save results into output table
morph_table = table(NMJFileNames,NerveTerminalPerimeterum, NerveTerminalAreaum2, TotalLengthOfBranchesum, AverageLengthOfBranchesum, Complexity, AChRPerimeterum, AChRAreaum2, AreaOfSynapticContactum2, Overlap, ManualEndplateAreaum2, ManualCompactness, Fragmentation);
end

