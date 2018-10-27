function [local_bool, global_bool, local_term, global_term] = FT_termination(trialseq,id,it)

    local_bool = true;
    global_bool = true;

    all_local = trialseq(trialseq(:,id.type) == 0,:);
    all_global = trialseq(trialseq(:,id.type) == 1,:);

    local_correct = all_local(all_local(:,id.acc) == 1,:);
    global_correct = all_global(all_global(:,id.acc) == 1,:);

    local_term = 100 * (size(local_correct,1) / size(all_local,1));
    global_term = 100 * (size(global_correct,1) / size(all_global,1));
    
    local_array = []; global_array = [];
    
    if size(all_local,1) >= 10 && size(all_global,1) >= 10
        for i = 1:11
            if trialseq(it-i,id.local_term) < 80 && trialseq(it-i,id.local_term) > 70
                local_array = [local_array,1];                
            else
                local_array = [local_array,0];
            end
        end
        
        if all(local_array)
            local_bool = false;
        end
        
        for i = 1:11
            if trialseq(it-i,id.global_term) < 80 && trialseq(it-i,id.global_term) > 70
                global_array = [global_array,1];                
            else
                global_array = [global_array,0];
            end
        end
        
        if all(global_array)
            global_bool = false;
        end
    end
end