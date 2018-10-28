function settings = FT_init(data)

    % Dummy calls
    HideCursor;
    
    % Trials
    if data.training == 0
        settings.general.loc_trials = 200;
        settings.general.glob_trials = 200;
    else
        settings.general.loc_trials = 10;
        settings.general.glob_trials = 10;
    end
            
    % Files
    settings.infolder = fileparts(which('FTS.m'));
    settings.outfolder = fullfile(fileparts(which('FTS.m')), 'out');
    clocktime = clock; hrs = num2str(clocktime(4)); mins = num2str(clocktime(5));
    settings.outfile = ['Subject_' num2str(data.nr) '_' date '_' hrs '.' mins 'h.mat'];
    
    % Flanker info
    settings.flanker.size = 3;
    settings.flanker.color = [128 128 128];
    
    % Durations
    settings.duration.stim = .2;
    settings.duration.check = 2;
    settings.duration.iti = .8;

    % Colors
    settings.color.bg = [0 0 0];
    
    % Screen
    screens = Screen('Screens');
    screenNumber = max(screens);
    [settings.screen.outwindow,settings.screen.outwindowdims] = Screen('OpenWindow', screenNumber, settings.color.bg);

end