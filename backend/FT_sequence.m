function trialseq = FT_sequence(settings,id,data)

    % shortcut
    col = length(fieldnames(id));

    % Create Clusters
    
    if data.training == 0 
        
        % create and establish colors/sides
        loc_trials = zeros(settings.general.loc_trials, col);
        
        loc_trials(1:20,id.color) = 6;
        loc_trials(1:10,id.side) = 1;
        loc_trials(11:20,id.side) = 2;
        
        loc_trials(21:40,id.color) = 6.5;
        loc_trials(21:30,id.side) = 1;
        loc_trials(31:40,id.side) = 2;
        
        loc_trials(41:60,id.color) = 7;
        loc_trials(41:50,id.side) = 1;
        loc_trials(51:60,id.side) = 2;
        
        loc_trials(61:80,id.color) = 7.5;
        loc_trials(61:70,id.side) = 1;
        loc_trials(71:80,id.side) = 2;
        
        loc_trials(81:100,id.color) = 8;
        loc_trials(81:90,id.side) = 1;
        loc_trials(91:100,id.side) = 2;
        
        loc_trials(101:120,id.color) = 8.5;
        loc_trials(101:110,id.side) = 1;
        loc_trials(111:120,id.side) = 2;
        
        loc_trials(121:140,id.color) = 9;
        loc_trials(121:130,id.side) = 1;
        loc_trials(131:140,id.side) = 2;
        
        loc_trials(141:160,id.color) = 9.5;
        loc_trials(141:150,id.side) = 1;
        loc_trials(151:160,id.side) = 2;
        
        loc_trials(161:180,id.color) = 10;
        loc_trials(161:170,id.side) = 1;
        loc_trials(171:180,id.side) = 2;
        
        loc_trials(181:200,id.color) = 10.5;
        loc_trials(181:190,id.side) = 1;
        loc_trials(191:120,id.side) = 2;

        % create and establish colors
        glob_trials = zeros(settings.general.glob_trials,col);
        
        glob_trials(1:20,id.color) = 6;
        glob_trials(1:10,id.side) = 1;
        glob_trials(11:20,id.side) = 2;
        
        glob_trials(21:40,id.color) = 6.5;
        glob_trials(21:30,id.side) = 1;
        glob_trials(31:40,id.side) = 2;
        
        glob_trials(41:60,id.color) = 7;
        glob_trials(41:50,id.side) = 1;
        glob_trials(51:60,id.side) = 2;
        
        glob_trials(61:80,id.color) = 7.5;
        glob_trials(61:70,id.side) = 1;
        glob_trials(71:80,id.side) = 2;
        
        glob_trials(81:100,id.color) = 8;
        glob_trials(81:90,id.side) = 1;
        glob_trials(91:100,id.side) = 2;
        
        glob_trials(101:120,id.color) = 8.5;
        glob_trials(101:110,id.side) = 1;
        glob_trials(111:120,id.side) = 2;
        
        glob_trials(121:140,id.color) = 9;
        glob_trials(121:130,id.side) = 1;
        glob_trials(131:140,id.side) = 2;
        
        glob_trials(141:160,id.color) = 9.5;
        glob_trials(141:150,id.side) = 1;
        glob_trials(151:160,id.side) = 2;
        
        glob_trials(161:180,id.color) = 10;
        glob_trials(161:170,id.side) = 1;
        glob_trials(171:180,id.side) = 2;
        
        glob_trials(181:200,id.color) = 10.5;
        glob_trials(181:190,id.side) = 1;
        glob_trials(191:200,id.side) = 2;
        
    else
        
        loc_trials = zeros(settings.general.loc_trials,col);
        glob_trials = zeros(settings.general.glob_trials,col);
        
        % Put in colors
        for i = 1:size(loc_trials,1)
            loc_trials(i,id.color) = 6 + ((i-1) * .5);
            glob_trials(i,id.color) = 6 + ((i-1) * .5);
        end
        
    end
    
    % establish type (local = 0; global = 1)
    loc_trials(:,id.type) = 0;
    glob_trials(:,id.type) = 1;

    % Merge
    trialseq = [loc_trials; glob_trials];
    
    % Shuffle
    ran = randperm(size(trialseq,1))';
    trialseq(:,id.trialNum) = ran;
    trialseq = sortrows(trialseq);
    
end









