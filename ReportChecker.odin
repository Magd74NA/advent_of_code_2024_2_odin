package report_checker

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

main :: proc() {
	data, success := os.read_entire_file_from_filename("input.txt")
	if success{

		defer(delete(data))

		str := string(data)
		lines := strings.split(str, "\n")

		unsafe_count : int = 0
		safe_count : int = 0
		

		for &value in lines{
			
			safe := true

			nums_str := strings.split(value," ")
			nums := make([dynamic]int)

			for &number_string in nums_str {
				append(&nums, strconv.atoi(number_string))
			}

			direction := false
			if nums[0]>nums[1] {
				direction = true
			}

			comp := nums[0]

			for i:=1; i < len(nums); i+=1 {
				if direction {
					if comp - nums[i] >3 || comp - nums[i] <=0 {
					safe = false
					break
					}
					comp = nums[i]
				}else {
					if comp - nums[i] < -3 || comp - nums[i] >= 0 {
					safe = false
					break
					}
					comp = nums[i]
				}
			}
			if safe {
				safe_count+=1
			}else{
				unsafe_count+=1
			}
		}
		fmt.printf("Safe sequences: %d\nUnsafe sequences: %d\n", safe_count, unsafe_count)
	}else{
		fmt.println("failed to read file")
	}
} 
