function [loc_values, glob_values] = FT_calcFeedback(trialseq,id)
    
    % Gather local and global trials
    localTrials = trialseq(trialseq(:,id.type) == 0,:);
    globalTrials = trialseq(trialseq(:,id.type) == 1,:);
    
    % Sort by color
    for i = 6:.5:10.5
        eval(['loc.c' num2str(i*10) ' = localTrials(localTrials(:,id.color) == i,:)']);
        eval(['glob.c' num2str(i*10) ' = globalTrials(globalTrials(:,id.color) == i,:)']);
    end

    loc_names = fieldnames(loc);
    glob_names = fieldnames(glob);
    
    loc_values = zeros(2,length(fieldnames(loc)));
    glob_values = zeros(2,length(fieldnames(glob)));

    for ii = 1:length(loc_names)
        loc_values(1,ii) = 100 * (size(loc.(loc_names{ii})(loc.(loc_names{ii})(:,id.acc) == 2,:),1) / 20);
        glob_values(1,ii) = 100 * (size(glob.(glob_names{ii})(glob.(glob_names{ii})(:,id.acc) == 2,:),1) / 20);
        disp(['Local Variable Accuracy Percentage at ' loc_names{ii} ' is: ' num2str(loc_values(1,ii))]);
        disp(['Global Variable Accuracy Percentage at ' glob_names{ii} ' is: ' num2str(glob_values(1,ii))]);
    end
    
end