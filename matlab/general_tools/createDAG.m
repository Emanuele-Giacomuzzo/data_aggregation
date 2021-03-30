function [DAG] = createDAG(A,TP)

%if the network had problems with the TP, then we need to eliminate cycles
%until the network gives us a good answer. At that point we need to
%calculate TP and that's going to be our ultimate TP. 

A = A - diag(diag(A));

all_cycles = 1;
cycles_deleted = 0;

while isempty(all_cycles) == 0
    
    TP = calculateTP(A);
    nan_inf = sum(isinf(TP)) + sum(isnan(TP));
    if nan_inf == 0
        final_TP = TP;
    end
    
    all_cycles = findCycles(A);
    
    tp = cell(length(all_cycles),1);
    out_links = cell(length(all_cycles),1);
    tp_to_next = cell(length(all_cycles),1);
    for cycle = 1:length(all_cycles)
        for node = 1:length(all_cycles{cycle})
            tp{cycle}(node) = TP(all_cycles{cycle}(node));
        end
        for node = 1:length(all_cycles{cycle})
            if node ~= length(all_cycles{cycle})
                out_links{cycle}(node) = A((all_cycles{cycle}(node)), (all_cycles{cycle}(node+1)));
                tp_to_next{cycle}(node) = abs(tp{cycle}(node)-tp{cycle}(node+1));
            else
                out_links{cycle}(node) = A((all_cycles{cycle}(node)), (all_cycles{cycle}(1)));
                tp_to_next{cycle}(node) = abs(tp{cycle}(node)-tp{cycle}(1));
            end
        end
    end
    
    lengths=zeros(length(all_cycles),1);
    for cycle = 1:length(all_cycles)
        lengths(cycle) = length(all_cycles{cycle});
        min_cycle_length = min(lengths);
    end
    
    for cycle = 1:length(all_cycles)
        if length(all_cycles{cycle}) == min_cycle_length
            if max(tp_to_next{cycle}) > 0.2 && nan_inf == 0
                [~,index_max] = max(tp_to_next{cycle});
                from = all_cycles{cycle}(index_max);
                if index_max ~= length(all_cycles{cycle})
                    to = all_cycles{cycle}(index_max+1);
                else 
                    to = all_cycles{cycle}(1);
                end
                A(from,to) = 0; cycles_deleted = cycles_deleted+1;
            else 
                [~,index_min_link] = min(out_links{cycle});
                min_link_from = all_cycles{cycle}(index_min_link);
                if index_min_link ~= length(all_cycles{cycle})
                    min_link_to = all_cycles{cycle}(index_min_link+1);
                else
                    min_link_to = all_cycles{cycle}(1);
                end
                A(min_link_from, min_link_to) = 0; cycles_deleted = cycles_deleted+1;
            end
        end
    end
end

DAG = A;
    
end