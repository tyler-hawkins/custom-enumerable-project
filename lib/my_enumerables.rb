module Enumerable
	# Your code goes here
	def my_each_with_index
		return to_enum unless block_given?
		i = 0
		while i < length
			yield(self[i], i)
			i += 1
		end
		self
	end

	def my_select
		return to_enum unless block_given?
		result = []
		my_each { |e| result.push(e) if yield e }
		result
	end

	def my_all?
		my_each { |e| return false if not yield e}
		true
	end

	def my_any?
		my_each { |e| return true if yield e }
		false
	end

	def my_none?
		my_each { |e| return false if yield e }
		true
	end
	
	def my_count 
		return length unless block_given?
		n = 0
		my_each { |e| n += 1 if yield e }
		n
	end

	def my_map(&block)
		result = []
		exp = -> {}
		if block_given?
			exp = -> (elem) { yield(elem) } 
		else
			exp = -> (elem) { block.call(elem) }
		end
		my_each { |e| result << exp.call(e) }
		result
	end

	def my_inject(&block)
		
	end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method

class Array 
	# Define my_each here
	def my_each(&block)
		# If no block is given, return the array as an enum to mock Array#each
		return to_enum unless block_given?
		i = 0
		# self here refers to the instance of an object, in this case it's the array that had my_each called on it 
		# Since this Array is an extension of Array, we can use .length
		while i < length
			# yield executes whatever the calling code gives in its do/end or { } block
			# self[i] here takes the place of whatever argument belongs to the passed in block
			block.call(self[i])
			# If array.some_other_func were invoked with no block argument, 
			# we would just write "yield" to run the code in the block
			
			i += 1
		end
		self
	end
end
