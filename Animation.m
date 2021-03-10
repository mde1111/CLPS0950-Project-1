%Animation: Neuromuscular Junction - started 3/3/21 (Katie Yetter)

%Questions for TA: Is the legend okay?  Is the order of the code okay? 

%Notes
    %Currently I have  two images: Both are 3 month male sternomastoid images: animal524_40x_03 from a HOM and animal551_40x_02 from a WT animal.
    %Channel 1 - postsynaptic (muscle endplate) & channel 2 - presynaptic (nerve terminal).
    
% Creating Animation
    %Display image overview experiment, as well as showing the sternomastoid muscle and wear it is located
        %This will be the original image presented

        
 %Help with this initial screen setup      

screens = Screen('Screens');
screenNumber = max(screens);
white  = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

[screenXpixels, screenYpixels] = Screen('WindowSize', window);
ifi = Screen('GetFlipInterval', window);
rr = FrameRate(window);
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);  
qw
PsychDefaultSetup(2);
the_img =imread('file:///Users/katieyetter/Pictures/Experimental%20Design%20main%20image.jpg'); %Photo of the initial experimental design
[s1, s2, ~] = size(the_img);
imageTexture = Screen('MakeTexture', window, the_img);
Screen('DrawTexture', window, imageTexture, [], [], 0);
Screen('Flip', window)
KbStrokeWait;
sca;

                        %Start of Animation

%Legend for key press
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 70);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Legend');
DrawFormattedText(window, 'Press  q for WT Presynaptic Neuron'); %Display WT gene mouse (presynaptic) 
DrawFormattedText(window, 'Press w for Deltalg3 Presynaptic Neuron'); %Display Deltalg3 gene mouse (presynaptic)
DrawFormattedText(window, 'Press e for WT Postsynaptic Neuron'); %Display WT gene mouse (postsynaptic)
DrawFormattedText(window, 'Press r for Deltalg3 Postsynaptic Neuron'); %Display Deltalg3 gene  mouse (postsynaptic)
DrawFormattedText(window, 'Press space to exit current image'); 
screenXpixels, screenYpixels * 0.5, [0 0 1];
Screen('Flip', window);

%Display instructions
Screen('TextSize', window, 18);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Instructions:', 18, 50, [0 0 0]);
DrawFormattedText(window, 'Refer to the legend to choose which image you want to see!', 20, 50, [0 1 0]);
DrawFormattedText(window,  'Press Space to close', 18, 50, [000]);
Screen('Flip', window);
rt = [];
respKey = [];
hasAnswered =  false;
while ~hasAnswered
    [keyIsDown,secs,keycode] = KbCheck;
    if keyIsdown
        if keyCode(space)
            ShowCursor;
            sca;
            return
        else
            hasAnswered = true;
            tEnd =  GetSecs;
        end
    end
    respKey = [respKey; KbName(keyCode)];
    rt = [rt; tEnd -  tStart];
    WaitSecs(2)
end


while quit == false
image = loadimage('file:///Users/katieyetter/Pictures/Experimental%20Design%20main%20image.jpg'); %Bring up original image of experimental data
end
%Press a Key based on the legend to see a specific part of the neuromuscular junction
answered = false;
while ~answered
[keyIsDown, secs, keyCode] = KbCheck;
if keyIsDown
  if strcmp(KbName(keyCode),'q') %check for key press
    image = loadimage('wildtype_presynaptic.jpg'); %Display WT gene mouse (presynaptic) 
  elseif strcmp(KbName(keyCode),'w') %check for key press
    image = loadimage('deltalg3_presynaptic.jpg'); %Display Deltalg3 gene mouse (presynaptic)
  elseif strcmp(KbName(keyCode),'e') %check for key press
    image = loadimage('wildtype_postsynaptic.jpg'); %Display WT gene mouse (postsynaptic)
  elseif strcmp(KbName(keyCode),'r') %check for key press
    image = loadimage('deltalg3_postsynaptic'); %Display Deltalg3 gene mouse (postsynaptic)
  elseif strcmp(KbName(keyCode),'space') %Exit current image
    quit = true;
    break
  end
end

%Display original image (Experimental Design) before closing application 

[window, windowRect] = PsychImaging(('file:///Users/katieyetter/Pictures/Experimental%20Design%20main%20image.jpg'), screenNumber, grey); %Bring up original image of experimental data
KbStrokeWait;
Priority(0);
sca; %This will close all windows
end

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