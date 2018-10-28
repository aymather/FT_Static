function trialseq = FT_backend(settings, trialseq, id)
    
    % shortcuts
    owd = settings.screen.outwindowdims;
    ow = settings.screen.outwindow;

    for it = 1:size(trialseq,1)

        % Stim locations (above or below fixation)
        if rand <= .5
            x1 = owd(3)/4;
            y1 = owd(4)/4;
            x2 = (owd(3)/4)*3;
            y2 = owd(4)/4;
        else
            x1 = owd(3)/4;
            y1 = (owd(4)/4)*3;
            x2 = (owd(3)/4)*3;
            y2 = (owd(4)/4)*3;
        end

        % Get random stims
        if trialseq(it,id.type) == 0

            if trialseq(it,id.side) == 1
                glo_drawFlankerTask(ow, 'left', '+', [x1,y1], settings.flanker.size, trialseq(it,id.color)); % locals
                glo_drawFlankerTask(ow, 'left', '+', [x2,y2], settings.flanker.size, trialseq(it,id.color));
            else
                glo_drawFlankerTask(ow, 'right', '+', [x1,y1], settings.flanker.size, trialseq(it,id.color));
                glo_drawFlankerTask(ow, 'right', '+', [x2,y2], settings.flanker.size, trialseq(it,id.color));
            end
            
        else

            if trialseq(it,id.side) == 1
                glo_drawFlankerTask(ow, '+', 'left', [x1,y1], settings.flanker.size, trialseq(it,id.color)); % globals
                glo_drawFlankerTask(ow, '+', 'left', [x2,y2], settings.flanker.size, trialseq(it,id.color));
            else
                glo_drawFlankerTask(ow, '+', 'right', [x1,y1], settings.flanker.size, trialseq(it,id.color));
                glo_drawFlankerTask(ow, '+', 'right', [x2,y2], settings.flanker.size, trialseq(it,id.color));
            end
            
        end
        
        Screen('DrawDots', ow, [owd(3)/2,owd(4)/2], 50, [255 255 255],[],2);

        % show stim
        stimonset = Screen('Flip',ow);

        while GetSecs - stimonset <= settings.duration.stim
            WaitSecs(.001);
        end
        
        Screen('FillRect', ow, 0);
        Screen('Flip', ow);

        % Check for response
        [trialseq(it,id.rt),trialseq(it,id.resp)] = glo_getmouse(settings.duration.check);

        % adjust for a miss to equal 99
        if trialseq(it,id.resp) == 0; trialseq(it,id.resp) = 99;end
        
        % Code accuracy
        if trialseq(it,id.resp) == trialseq(it,id.side)
            trialseq(it,id.acc) = 1;
        else
            trialseq(it,id.acc) = 2;
        end
        
        WaitSecs(settings.duration.iti);

        save(fullfile(settings.outfolder,settings.outfile),'trialseq','settings');

    end
    
end

