%Animation: Neuromuscular Junction Images - started 3/3/21 (Katie Yetter)

                                  %Notes
    % 1. Four images: All are 3 month male sternomastoid images: animal524_40x_03 from a HOM (Deltalg3) and animal551_40x_02 from a WT gene.
    % 2. Channel 1 - postsynaptic (muscle endplate) & channel 2 - presynaptic (nerve terminal).
    
                        % Creating Animation: Layout
   % 1. Display experiment overview in main image -- then provide detailed
   %images of the presynaptic and postsynaptic neurons in the WT & HOM
   %genes within the mice.
   % 2. The sternomastoid muscle is where these neurons are located

                % Set Screen Preferences/Background Image                
Screen('Preference', 'SkipSyncTests', 1);
PsychDefaultSetup(2);   
screens = Screen('Screens');
screenNumber = max(screens);
white  = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
ifi = Screen('GetFlipInterval', window);
rr = FrameRate(window);
  

                        %Display Animation instructions
Screen('TextSize', window, 20);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Instructions: \n \nRefer to the legend to choose which image you want to see! \n \nPress space to close.', 18, 50, [0 0 1]);
screenXpixels * 0.5; screenYpixels * 0.5; [0 0 1];

                        %Display Experimental Design Image
the_img = imread('file:///Users/katieyetter/Pictures/Experimental%20Design%20main%20image.jpg'); %Photo of the initial experimental design
imageTexture = Screen('MakeTexture', window, the_img);
[s1, s2, ~] = size(the_img); %make image bigger 
Screen('DrawTexture', window, imageTexture, [], [], 0);
Screen('Flip', window);
continueKey = KbName('space');
hasAnswered = false;
while ~hasAnswered
     [keyIsDown, secs, keyCode] = KbCheck;
     if keyIsDown
          if keyCode(continueKey) 
             hasAnswered = true;
         end
     end
end            
 

           %View Neuronal Images using key press Legend                         
quit = false;
while ~quit
Screen('TextSize', window, 30);
Screen('TextFont', window, 'Courier');
%screenXpixels * 0.5, screenYpixels * 0.5, [0 0 1];  
DrawFormattedText(window, 'Legend \n \nPress q for WT Presynaptic Neuron \n \nPress w for Deltalg3 Presynaptic Neuron \n \nPress e for WT Postsynaptic Neuron \n \nPress r for Deltalg3 Postsynaptic Neuron \n \nPress space to exit current image'); 
    %Display WT gene mouse  photo (presynaptic) 
    %Display Deltalg3 gene mouse photo (presynaptic)
    %Display WT gene mouse photo (postsynaptic)
    %Display Deltalg3 gene mouse photo (postsynaptic)
   
Screen('Flip', window);
KbStrokeWait; 
   
    %Press the indicated key to see a specific part of the neuromuscular junction


[~, keycode] = KbStrokeWait;
  if strcmp(KbName(keyCode),'q') %check for key press
    image = loadimage('wildtype_presynaptic.jpg'); %Display WT gene mouse (presynaptic) 
    image = imread('wildtype_presynaptic.jpg');
    KbStrokeWait;
  elseif strcmp(KbName(keyCode),'w') %check for key press
    image = loadimage('deltalg3_presynaptic.jpg'); %Display Deltalg3 gene mouse (presynaptic)
    image = imread('deltalg3_presynaptic.jpg');
    KbStrokeWait;
  elseif strcmp(KbName(keyCode),'e') %check for key press
    image = loadimage('wildtype_postsynaptic.jpg'); %Display WT gene mouse (postsynaptic)
    image = imread('wildtype_postsynaptic.jpg');
    KbStrokeWait;
  elseif strcmp(KbName(keyCode),'r') %check for key press
    image = loadimage('deltalg3_postsynaptic'); %Display Deltalg3 gene mouse (postsynaptic)
    image = imread('deltalg3_postsynaptic');
    KbStrokeWait;
  elseif strcmp(KbName(keyCode),'space') %Exit current image
    quit = true;
    break
  end
end
Priority(0);
sca; %This will close all windows


%%% Alternative method to displaying images %%%%%%

%This code will allow two images to be brought onto the same window side-by-side
%I will want to do this multiple times based on key input
%[X1,map1]=imread('add primary image here'); %This is the main image
%[X2,map2]=imread('110819_animal551_40x_02.tif'); %WT Male mouse: Channel 1 is postsynaptic (muscle endplate) and channel 2 is presynaptic (nerve terminal).
%subplot(1,2,1), imshow(X1,map1)
%subplot(1,2,2), imshow(X2,map2)

%[X1,map1]=imread('add primary image here'); %This is the main image
%[X2,map2]=imread('111019_animal524_40x_03.tif'); %HOM Male mouse: Channel 1 is postsynaptic (muscle endplate) and channel 2 is presynaptic (nerve terminal).
%subplot(1,2,1), imshow(X1,map1)
%subplot(1,2,2), imshow(X2,map2)
