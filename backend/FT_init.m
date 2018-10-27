function settings = FT_init(data)

    % Dummy calls
    HideCursor;
    
    % Files
    settings.infolder = fileparts(which('FT.m'));
    settings.outfolder = fullfile(fileparts(which('FT.m')), 'out');
    clocktime = clock; hrs = num2str(clocktime(4)); mins = num2str(clocktime(5));
    settings.outfile = ['Subject_' num2str(data.nr) '_' date '_' hrs '.' mins 'h.mat'];
    
    % Flanker info
    settings.flanker.size = 3;
    settings.flanker.color = [128 128 128];
    
    % Durations
    settings.duration.stim = .2;
    settings.duration.check = 2;

    % Colors
    settings.color.bg = [0 0 0];
    
    % Screen
    screens = Screen('Screens');
    screenNumber = max(screens);
    [settings.screen.outwindow,settings.screen.outwindowdims] = Screen('OpenWindow', screenNumber, settings.color.bg);

end