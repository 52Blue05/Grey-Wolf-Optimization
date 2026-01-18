function Archive = updateArchive(Archive, pos, cost)

    dominated = false;
    removeIdx = [];

    for i = 1:numel(Archive)
        if all(cost <= Archive(i).cost) && any(cost < Archive(i).cost)
            removeIdx(end+1) = i;
        elseif all(Archive(i).cost <= cost)
            dominated = true;
            break;
        end
    end

    if ~dominated
        Archive(removeIdx) = [];
        Archive(end+1).pos = pos;
        Archive(end).cost = cost;
    end
end
