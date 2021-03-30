function node_colors = assignNodeColors(WDCs_before_strength, WDCs_after_strength)

for node = 1:length(WDCs_before_strength)
    if WDCs_before_strength(node) == "central" && WDCs_after_strength(node) == "central"
        node_colors(node) = "red";
    elseif WDCs_before_strength(node) == "central" && WDCs_after_strength(node) == "not central"
        node_colors(node) = "orange";
    elseif WDCs_before_strength(node) == "not central" && WDCs_after_strength(node) == "central"
        node_colors(node) = "purple";
    elseif WDCs_before_strength(node) == "not central" && WDCs_after_strength(node) == "not central"
        node_colors(node) = "#44ABE7";
    else
        node_colors(node) = "something's wrong";
    end
end

node_colors = node_colors';


end