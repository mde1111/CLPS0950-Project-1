%Animation: Neuromuscular Junction Images - started 3/3/21 (Katie Yetter)

%Notes
% 1. Four images: All are 3 month male sternomastoid images: animal524_40x_03 from a HOM (DeltaIg3) and animal551_40x_02 from a WT gene.
% 2. Channel 1 - postsynaptic (muscle endplate) & channel 2 - presynaptic (nerve terminal).

% Creating Animation: Layout
% 1. Display experiment overview in main image -- then provide detailed
%images of the presynaptic and postsynaptic neurons in the WT & HOM
%genes within the mice.
% 2. The sternomastoid muscle is where these neurons are located

% Set Screen Preferences/Background Image
Screen('Preference', 'SkipSyncTests', 1);
PsychDefaultSetup(2);
%PsychDebugWindowConfiguration(0, 0.5) -- this is only used to aid in
                                                            %debugging
screens = Screen('Screens'); %Allows PTB to see how many screens are being used
screenNumber = max(screens); %find max # of screen -- if more than one, larger one  will be used
%define colors  to get gray background
white  = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);  %set background image to gray
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel); %prevent other apps from opening
[screenXpixels, screenYpixels] = Screen('WindowSize', window); %displays animation on your full screen size
ifi = Screen('GetFlipInterval', window);
rr = FrameRate(window);


%Display Animation instructions
Screen('TextSize', window, 20);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Instructions: \n \nRefer to the legend to choose which image you want to see! \n \nPress space to close.', 18, 50, [0 0 1]);
screenXpixels * 0.5; screenYpixels * 0.5; [0 0 1]; %color and location of text

%Display Experimental Design Image
the_img = imread('file:///Users/katieyetter/Pictures/Experimental%20Design%20main%20image.jpg'); %Photo of the initial experimental design
imageTexture = Screen('MakeTexture', window, the_img); %format image in PTB language
[s1, s2, ~] = size(the_img); 
Screen('DrawTexture', window, imageTexture, [], [], 0);
Screen('Flip', window); %display image
continueKey = KbName('space'); %space  bar will bring you to next window
hasAnswered = false;
while ~hasAnswered
    [keyIsDown, secs, keyCode] = KbCheck; %check to see if space bar has been hit in order to move  on
    if keyIsDown
        if keyCode(continueKey)
            hasAnswered = true; %if the space bar has been hit, end loop
        end
    end
end


%View Neuronal Images using key press Legend
quit = false;
while ~quit %run  code until quit becomes true and you want to exit
    Screen('TextSize', window, 30);
    Screen('TextFont', window, 'Courier');
    %Display WT gene mouse  photo (presynaptic)
    %Display DeltaIg3 gene mouse photo (presynaptic)
    %Display WT gene mouse photo (postsynaptic)
    %Display DeltaIg3 gene mouse photo (postsynaptic)
    DrawFormattedText(window, 'Legend \n \nPress q for WT Presynaptic Neuron \n \nPress w for Deltalg3 Presynaptic Neuron \n \nPress e for WT Postsynaptic Neuron \n \nPress r for Deltalg3 Postsynaptic Neuron \n \nPress space to exit current image');
    
    Screen('Flip', window); %display image
    
    %Press the indicated key to see a specific part of the neuromuscular junction
    
    [~, KbCode] = KbStrokeWait;
    if KbCode(20)== 1  %check for key press
         %Display WT gene mouse (presynaptic)
        image = imread('wildtype_presynaptic.jpg');
        imageTexture = Screen('MakeTexture', window, image);%display image in format PTB understands
        Screen('DrawTexture', window, imageTexture, [], [], 0);
        Screen('Flip', window); %display image
        KbStrokeWait;
    elseif KbCode(26)== 1  %check for key press
         %Display Deltalg3 gene mouse (presynaptic)
        image = imread('deltaIg3_presynaptic.jpg');
        imageTexture = Screen('MakeTexture', window, image); %display image in format PTB understands
        Screen('DrawTexture', window, imageTexture, [], [], 0); 
        Screen('Flip', window); %display image
        KbStrokeWait; %wait for key press
    elseif KbCode(8) == 1  %check for key press
         %Display WT gene mouse (postsynaptic)
        image = imread('wildtype_postsynaptic.jpg');
        imageTexture = Screen('MakeTexture', window, image); %display image in format PTB understands
        Screen('DrawTexture', window, imageTexture, [], [], 0); 
        Screen('Flip', window);
        KbStrokeWait; %wait for key press
    elseif KbCode(21) == 1   %check for key press
        %Display Deltalg3 gene mouse (postsynaptic)
        image = imread('deltaIg3_postsynaptic.jpg');
        imageTexture = Screen('MakeTexture', window, image);%display image in format PTB understands
        Screen('DrawTexture', window, imageTexture, [], [], 0);  
        Screen('Flip', window); %display image
        KbStrokeWait; %wait for key press
    elseif KbCode(44) == 1  %Exit current image
        quit = true; %quit is true; end program once loop is complete
        break
    end
end
Priority(0);
sca; %This will close all windows