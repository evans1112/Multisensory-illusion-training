clc;clear;close all
InitializePsychSound;
Screen( 'Preference', 'VisualDebugLevel', 0 );
Screen( 'Preference', 'Verbosity', 0 );
Screen( 'Preference', 'SkipSyncTests', 1 );
ListenChar(2);
%-----------------------------1.Pre-experimental preparation---------------------

try
    block=8;
    Trials=60;
    singleStiNum=Trials/6  ;
    designM2=fullfact([singleStiNum*block,6]);
    randIdx=Shuffle(1:480);
    designM2=designM2(randIdx,:);
    trialNum=0;
    feedback_1=zeros(block*Trials,4);
    SOA=0.066;%66ms
    Dur=0.017;
    KCname1=KbName('b');
    KCname2=KbName('m');
    KCname4=KbName('space');
    endTrialNum=3 ;%check£¡£¡
    rightrate=zeros(6,2);
    randTchoice=zeros(480,1);
    for i=1:120
        randTchoice(4*i,1)=1.1;
        randTchoice(4*i-1,1)=1;
        randTchoice(4*i-2,1)=0.9;
        randTchoice(4*i-3,1)=0.8;
    end
    randIdx2=Shuffle(1:480);
    randTchoice=randTchoice(randIdx2,:);
    
    
    freq=48000;
    pahandle=PsychPortAudio('Open',[],1,1,freq,2);
    PsychPortAudio('Volume',pahandle,1);
    myBeep=MakeBeep(3500,0.007,freq);
    PsychPortAudio('FillBuffer',pahandle,[myBeep;myBeep]);
    
    %-----------------------------2.Start---------------------
    [w,wRect]=Screen('OpenWindow',0,0);
    [x,y]=RectCenterd(wRect);
    pic_instru = Screen('MakeTexture', w, imread('SIFI_instru.png'));
    Screen('DrawTexture',w,pic_instru,[],[]); 
    Screen('Flip',w,0); 
    
    Screen('TextSize',w,40);
    while 1
        [KD,Secs,KC]=KbCheck(-1);
        if KC(KCname4)
            break
        end
    end
    WaitSecs(2);
    
    for trialNum=1:endTrialNum
        randT=randTchoice(trialNum,1);
        feedback_1(trialNum,1)=trialNum;
       DrawFormattedText(w,'+','center','center',[255 255 255]);
       Screen('Flip',w,0);
        WaitSecs(randT);
        
        %-----------------------------2.1 F1---------------------
        switch designM2(trialNum,2)
            case 1
                feedback_1(trialNum,2)=1;
                DrawFormattedText(w,'+','center','center',[255 255 255]);
                Screen('FillArc',w,[255 255 255],[x-45.5 y+106.5 x+45.5 y+197.5],0,360);
                onsetime=Screen('Flip',w,0);
                DrawFormattedText(w,'+','center','center',[255 255 255]);
                onsetime=Screen('Flip',w,onsetime+Dur);
                
                respT=0;
                t1=GetSecs;
                while 1
                    [KD,Secs,KC]=KbCheck(-1);
                    t2=GetSecs;
                    if KC(KCname1)
                        respT=t2-t1;
                        feedback_1(trialNum,3)=1;
                        DrawFormattedText(w,'correct','center','center',[0 255 0]);
                        Screen('Flip',w,0);
                        WaitSecs(1);
                        break
                    elseif KC(KCname2)
                        respT=t2-t1;
                        feedback_1(trialNum,3)=0;
                        DrawFormattedText(w,'incorrect','center','center',[255 0 0]);
                        Screen('Flip',w,0);
                        WaitSecs(1);
                        break
                        
                    end
                    if t2-t1>3
                        feedback_1(trialNum,3)=0;
                        DrawFormattedText(w,'no reaction','center','center',[0 0 255]);
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        respT=0;
                        break;
                    end
                end
                
                
                %-----------------------------2.2F2---------------------
            case 2
                feedback_1(trialNum,2)=2;
                DrawFormattedText(w,'+','center','center',[255 255 255]);
                Screen('FillArc',w,[255 255 255],[x-45.5 y+106.5 x+45.5 y+197.5],0,360);
                onsetime=Screen('Flip',w,0);
                DrawFormattedText(w,'+','center','center',[255 255 255]);
                onsetime=Screen('Flip',w,onsetime+Dur);
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                Screen('FillArc',w,[255 255 255],[x-45.5 y+106.5 x+45.5 y+197.5],0,360);
                onsetime=Screen('Flip',w,onsetime+SOA);
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                onsetime=Screen('Flip',w,onsetime+Dur);
                respT=0;
                
                t1=GetSecs;
                while 1
                    [KD,Secs,KC]=KbCheck(-1);
                    t2=GetSecs;
                    if KC(KCname2)
                        respT=t2-t1; %
                        feedback_1(trialNum,3)=1;
                        DrawFormattedText(w,'correct','center','center',[0 255 0]);%%
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        break
                    elseif KC(KCname1)
                        respT=t2-t1;
                        feedback_1(trialNum,3)=0;
                        
                        DrawFormattedText(w,'incorrect','center','center',[255 0 0]);%%
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        break
                        
                    end
                    if t2-t1>3
                        feedback_1(trialNum,3)=0;%
                        DrawFormattedText(w,'no reaction','center','center',[0 0 255]);%%
                        Screen('Flip',w,0);
                        
                        
                        WaitSecs(1);
                        respT=0;%%
                        break;
                    end
                end
                
                %-----------------------------2.3F1B1---------------------
            case 3
                feedback_1(trialNum,2)=3;
                
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                Screen('FillArc',w,[255 255 255],[x-45.5 y+106.5 x+45.5 y+197.5],0,360);
                
                
                %t3=GetSecs;
                onsetime=Screen('Flip',w, 0);
                PsychPortAudio('Start',pahandle,1,0,1);
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                onsetime=Screen('Flip',w,onsetime+Dur);
                
                %t5=t4-t3
                respT=0;
                t1=GetSecs;
                while 1
                    [KD,Secs,KC]=KbCheck(-1);
                    t2=GetSecs; %
                    if KC(KCname1)% 
                        %t2=GetSecs;
                        respT=t2-t1;   %
                        feedback_1(trialNum,3)=1;
                        
                        DrawFormattedText(w,'correct','center','center',[0 255 0]);%%
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        
                        break; 
                    elseif KC(KCname2)
                        % t2=GetSecs;
                        respT=t2-t1;
                        feedback_1(trialNum,3)=0;
                        DrawFormattedText(w,'incorrect','center','center',[255 0 0]);%%
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        break
                    end
                    if t2-t1>3
                        feedback_1(trialNum,3)=0;%
                        DrawFormattedText(w,'no reaction','center','center',[0 0 255]);%%
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        respT=0;
                        break;
                    end
                end
                
                
                
                
                %-----------------------------2.4F2B1---------------------
            case 4
                feedback_1(trialNum,2)=4;
                
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                Screen('FillArc',w,[255 255 255],[x-45.5 y+106.5 x+45.5 y+197.5],0,360);
                
                
                onsetime=Screen('Flip',w, 0);
                PsychPortAudio('Start',pahandle,1,0,1);
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                onsetime=Screen('Flip',w,onsetime+Dur);
                t3=GetSecs;
                
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                Screen('FillArc',w,[255 255 255],[x-45.5 y+106.5 x+45.5 y+197.5],0,360);
                
                onsetime=Screen('Flip',w,onsetime+SOA-1/120);
                t4=GetSecs;
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                onsetime=Screen('Flip',w,onsetime+Dur);
                t4=t4-t3
                
                t1=GetSecs;
                while 1
                    [KD,Secs,KC]=KbCheck(-1);
                    t2=GetSecs; %
                    if KC(KCname2)% 
                        %t2=GetSecs;
                        respT=t2-t1;   %
                        feedback_1(trialNum,3)=1;
                        
                        DrawFormattedText(w,'correct','center','center',[0 255 0]);%%
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        
                        break;  %
                    elseif KC(KCname1)
                        % t2=GetSecs;
                        respT=t2-t1;
                        feedback_1(trialNum,3)=0;
                        DrawFormattedText(w,'incorrect','center','center',[255 0 0]);%%
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        break
                    end
                    if t2-t1>3
                        feedback_1(trialNum,3)=0;%
                        DrawFormattedText(w,'no reaction','center','center',[0 0 255]);%%
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        respT=0;%%%
                        break;
                    end
                end
                
                %-----------------------------2.5F1B2---------------------
                
            case 5
                feedback_1(trialNum,2)=5;
                
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                Screen('FillArc',w,[255 255 255],[x-45.5 y+106.5 x+45.5 y+197.5],0,360);
                
                onsetime=Screen('Flip',w, 0);
                PsychPortAudio('Start',pahandle,1,0,1);
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                onsetime=Screen('Flip',w,onsetime+Dur);
                t5=GetSecs;
              
                PsychPortAudio('Start',pahandle,1,onsetime+SOA,1);
                t6=GetSecs;
                
                t5=t6-t5
                t1=GetSecs;
                while 1
                    [KD,Secs,KC]=KbCheck(-1);
                    t2=GetSecs; %
                    if KC(KCname1)% 
                        %t2=GetSecs;
                        respT=t2-t1;   %
                        feedback_1(trialNum,3)=1;
                        
                        DrawFormattedText(w,'correct','center','center',[0 255 0]);%%
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        
                        break;  %
                    elseif KC(KCname2)
                        
                        respT=t2-t1;
                        feedback_1(trialNum,3)=0;
                        DrawFormattedText(w,'incorrect','center','center',[255 0 0]);%%
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        break
                    end
                    if t2-t1>3
                        feedback_1(trialNum,3)=0;%
                        DrawFormattedText(w,'no reaction','center','center',[0 0 255]);%%
                        Screen('Flip',w,0);
                        
                        
                        WaitSecs(1);
                        respT=0;
                        break;
                    end
                end
                
                
                %-----------------------------2.6F2B2---------------------
            case 6
                feedback_1(trialNum,2)=6;
                
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                Screen('FillArc',w,[255 255 255],[x-45.5 y+106.5 x+45.5 y+197.5],0,360);
                
                
                onsetime=Screen('Flip',w, 0);
                PsychPortAudio('Start',pahandle,1,0,1);
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                onsetime=Screen('Flip',w,onsetime+Dur);
                t8=GetSecs;
                %                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                %                 onsetime=Screen('Flip',w,onsetime+SOA);
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                Screen('FillArc',w,[255 255 255],[x-45.5 y+106.5 x+45.5 y+197.5],0,360);
                onsetime=Screen('Flip',w,onsetime+SOA-1/120);
                t9=GetSecs;
                DrawFormattedText(w,'+','center','center',[255 255 255]);%%
                PsychPortAudio('Start',pahandle,1,0,1);
                onsetime=Screen('Flip',w,onsetime+Dur);
                t6=t9-t8
                t1=GetSecs;
                while 1
                    [KD,Secs,KC]=KbCheck(-1);
                    t2=GetSecs; %
                    if KC(KCname2)% 
                        %t2=GetSecs;
                        respT=t2-t1;   %
                        feedback_1(trialNum,3)=1;
                        
                        DrawFormattedText(w,'correct','center','center',[0 255 0]);%%
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        
                        break;  
                    elseif KC(KCname1)
                        % t2=GetSecs;
                        respT=t2-t1;
                        feedback_1(trialNum,3)=0;
                        DrawFormattedText(w,'incorrect','center','center',[255 0 0]);%%
                        Screen('Flip',w,0);
                        
                        WaitSecs(1);
                        break
                    end
                    if t2-t1>3
                        feedback_1(trialNum,3)=0;%
                        DrawFormattedText(w,'no reaction','center','center',[0 0 255]);%%
                        Screen('Flip',w,0);
                        WaitSecs(1);
                        respT=0;
                        break;
                    end
                end
                
                
        end
        
        
        
        feedback_1(trialNum,4)=respT;
        % -----------------------------3.Break time--------------------
        if trialNum==60||trialNum==120||trialNum==180||trialNum==240||trialNum==300||trialNum==360||trialNum==420
            pic_instru3 = Screen('MakeTexture', w, imread('breaktime.png'));
            Screen('DrawTexture',w,pic_instru3,[],[]); 
            Screen('Flip',w,0);
            WaitSecs(3);
            while 1
                [KD,Secs,KC]=KbCheck(-1);
                if KC(KCname4)
                    break
                end
            end
            WaitSecs(3);
        end
        %-----------------------------3.2 End--------------------
        
        
    end
    pic_instru2 = Screen('MakeTexture', w, imread('endtime.png'));
    Screen('DrawTexture',w,pic_instru2,[],[]);
    Screen('Flip',w,0); 
    WaitSecs(3);
    PsychPortAudio('Close',pahandle);
    ListenChar(1);
    sca;
catch
    test_error;
    sca;
    rethrow(test_error);
    
end
%-----------------------------4.Data processing--------------------

%%--------------------4.1 Accuracy----------------------------------

for findType=1:6
    rightNum=0;
    singleNum=0;
    rightrate(findType,1)=findType;
    for oneTrial=1:trialNum
        if feedback_1(oneTrial,2)==findType
            singleNum=singleNum+1;
            if feedback_1(oneTrial,3)==1
                rightNum=rightNum+1;
            end
            
        end
    end
    rightrate(findType,2)=rightNum/singleNum;
end


%-----------------------------5.Export Data--------------------
picFolderName_1 = 'subinfo_1';
if ~exist(picFolderName_1, 'dir')
    mkdir(picFolderName_1)
end


sub_shuchu=num2cell(feedback_1);
header0 = {'trials', 'Type','right','RT'};
sub_data = cell2table(sub_shuchu, 'VariableNames', header0);
exp_data = strcat('subinfo_1/', 'DATA_SIFI','_', '.csv');
writetable(sub_data, exp_data);

sub_shuchu2=num2cell(rightrate);
header1 = {'Type', 'Accuracy'};
sub_data2 = cell2table(sub_shuchu2, 'VariableNames', header1);
exp_data2 = strcat('subinfo_1/', 'Accuracy_SIFI','_', '.csv');
writetable(sub_data2, exp_data2);

