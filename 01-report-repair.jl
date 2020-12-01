using DelimitedFiles

function file_to_array(infile)
	 array = readdlm(infile, ',', Int, '\n')
	 return array	 
end
function number_pair_search(report_array::Array{Int})
	 found_values = []
	 for reportnum::Int in report_array
	     complement::Int = 2020 - reportnum
	     found = findall(isequal(complement), report_array)
	     if size(found)[1] == 1
	     	found_values = [reportnum, complement]
		break
	     end
	 end
	 if size(found_values)[1] == 2
	    return found_values
	 else
	    return "Could not find a pair of values that sum to 2020.\n"
	 end
end

function number_triplet_search(report_array::Array{Int})
	 found_values = []
	 for i in 1:size(report_array,1)
	     complement::Int = 2020 - report_array[i]
	     for j in 2:size(report_array,1)
	         found = findall(isequal(complement-report_array[j]), report_array)
	     	 if size(found)[1] == 1
	     	    found_values = [report_array[i], report_array[j], complement-report_array[j]]
		    break
		 end
	     end
	 end
	 if size(found_values)[1] == 3
	    return found_values
	 else
	    return "Could not find a triplet of values that sum to 2020.\n"
	 end
end


function calculate_product(values)
	 product = 1
	 for i in 1:size(values,1)
	     product *= values[i]
	 end
	 
	 return product
end

function main()
    val_array = file_to_array("input/01.txt")
    pair_values = number_pair_search(val_array)
    @assert size(pair_values)[1] == 2
    pair_product = calculate_product(pair_values)
    println("Pair values product: $pair_product")
    triplet_values = number_triplet_search(val_array)
    @assert size(triplet_values)[1] == 3
    triple_product = calculate_product(triplet_values)
    println("Triplet values product: $triple_product")
end

main()