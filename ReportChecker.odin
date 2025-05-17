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
			if direction{
				comp+=1
			}else{
				comp-=1
			}
			for &val in nums {
				if direction {
					if comp - val >3 || comp - val <=0 {
					safe = false
					break
					}
					comp = val
				}else {
					if comp - val < -3 || comp -val >= 0 {
					safe = false
					break
					}
					comp = val
				}
			}
			if safe {
				safe_count+=1
			}else{
				unsafe_count+=1
			}
		}
		buf: [4]byte
		buf2: [4]byte

		safe_string := strconv.itoa(buf[:], safe_count)
		unsafe_string := strconv.itoa(buf2[:], unsafe_count)
		fmt.println("unsafe:")
		fmt.println(unsafe_string)
		fmt.println("safe:")
		fmt.print(safe_string)
	}else{
		fmt.println("failed to read file")
	}
} 
