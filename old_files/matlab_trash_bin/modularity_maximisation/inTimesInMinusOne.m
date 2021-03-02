function[in_times_in_minus_one]=inTimesInMinusOne(indegree)

in_times_in_minus_one=0;

for i=1:length(indegree)
    in_times_in_minus_one=in_times_in_minus_one+indegree(i)*[indegree(i)-1];
end

end