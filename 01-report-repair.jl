using DelimitedFiles

function file_to_array(infile)
	 array = readdlm(infile, ',', Int, '\n')
	 return array	 
end
function number_search(report_array::Array{Int})
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

function main()
    val_array = file_to_array("input/01.txt")
    values = number_search(val_array)
    println(values)
end

main()