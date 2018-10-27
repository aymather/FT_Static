function [trialseq, local_final, global_final] = FT_backend(settings, id)

    % init incrementers
    increment.local = 30;
    increment.global = 30;
    
    % Set flags for termination conditions
    local_bool = true;
    global_bool = true;

    % init trialseq
    trialseq = zeros(1,length(fieldnames(id)));
    trialseq(:,id.trialNum) = 1;
    
    % get colors
    color_local = settings.flanker.color;
    color_global = settings.flanker.color;
    
    % init colors into trialseq
    trialseq(:,id.local_color) = color_local(1);
    trialseq(:,id.global_color) = color_global(1);
    
    % shortcuts
    owd = settings.screen.outwindowdims;
    ow = settings.screen.outwindow;

    Screen('DrawDots', ow, [owd(3)/2,owd(4)/2], 50, [255 255 255],[],2);
    Screen('Flip', ow);
    
    % start iterator
    it = 1;

    while local_bool == true || global_bool == true

        color_local = trialseq(it,id.local_color);
        color_global = trialseq(it,id.global_color);

        % Stim locations
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
        if rand <=.5
            trialseq(it,id.type) = 0;
            if rand <= .5
                trialseq(it,id.side) = 1;
                glo_drawFlankerTask(ow, 'left', '+', [x1,y1], settings.flanker.size, color_local); % locals
                glo_drawFlankerTask(ow, 'left', '+', [x2,y2], settings.flanker.size, color_local);
            else
                trialseq(it,id.side) = 2;
                glo_drawFlankerTask(ow, 'right', '+', [x1,y1], settings.flanker.size, color_local);
                glo_drawFlankerTask(ow, 'right', '+', [x2,y2], settings.flanker.size, color_local);
            end
        else
            trialseq(it,id.type) = 1;
            if rand <= .5
                trialseq(it,id.side) = 1;
                glo_drawFlankerTask(ow, '+', 'left', [x1,y1], settings.flanker.size, color_global); % globals
                glo_drawFlankerTask(ow, '+', 'left', [x2,y2], settings.flanker.size, color_global);
            else
                trialseq(it,id.side) = 2;
                glo_drawFlankerTask(ow, '+', 'right', [x1,y1], settings.flanker.size, color_global);
                glo_drawFlankerTask(ow, '+', 'right', [x2,y2], settings.flanker.size, color_global);
            end
        end
        
        Screen('DrawDots', ow, [owd(3)/2,owd(4)/2], 50, [255 255 255],[],2);

        % show stim
        stimonset = Screen('Flip',ow);

        while GetSecs - stimonset <= settings.duration.stim
            WaitSecs(.001);
        end
        
        Screen('FillRect', ow, 0);
        Screen('DrawDots', ow, [owd(3)/2,owd(4)/2], 50, [255 255 255],[],2);
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

        % Get another trialseq row
        trialseq = [trialseq; zeros(1,length(fieldnames(id)))];
        trialseq(it+1,id.trialNum) = it+1;
        trialseq(it+1,id.local_color) = trialseq(it,id.local_color);
        trialseq(it+1,id.global_color) = trialseq(it,id.global_color);

        % Color schemes
        if trialseq(it,id.type) == 0 && trialseq(it,id.resp) == trialseq(it,id.side) % local
            trialseq(it+1,id.local_color) = trialseq(it,id.local_color) - increment.local;
        elseif trialseq(it,id.type) == 0 && trialseq(it,id.resp) ~= trialseq(it,id.side)
            trialseq(it+1,id.local_color) = trialseq(it,id.local_color) + increment.local;
        elseif trialseq(it,id.type) == 1 && trialseq(it,id.resp) == trialseq(it,id.side)
            trialseq(it+1,id.global_color) = trialseq(it,id.global_color) - increment.global;
        elseif trialseq(it,id.type) == 1 && trialseq(it,id.resp) ~= trialseq(it,id.side)
            trialseq(it+1,id.global_color) = trialseq(it,id.global_color) + increment.global;
        end

        % Change the incrementer
        if trialseq(it+1,id.local_color) < 10; trialseq(it+1,id.local_color) = 10;increment.local = 5;end
        if trialseq(it+1,id.global_color) < 10; trialseq(it+1,id.global_color) = 10;increment.global = 5;end

        if trialseq(it+1,id.local_color) < 5; trialseq(it+1,id.local_color) = 5;increment.local = 2;end
        if trialseq(it+1,id.global_color) < 5; trialseq(it+1,id.global_color) = 5;increment.global = 2;end

        if trialseq(it+1,id.local_color) <= 3;increment.local = 1;end
        if trialseq(it+1,id.global_color) <= 3;increment.global = 1;end

        % Check accuracy and termination condition
        [local_bool, global_bool, trialseq(it,id.local_term), trialseq(it,id.global_term)] = FT_termination(trialseq,id,it);

        if local_bool == false; local_final = trialseq(it,id.local_color);end
        if global_bool == false;global_final = trialseq(it,id.global_color);end
        
        WaitSecs(1);

        it = it + 1;

        save(fullfile(settings.outfolder,settings.outfile),'trialseq','settings');

    end
    
end

