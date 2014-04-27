#!/usr/bin/ruby -w

puts "-----Console-interpreter START-----\n"

# -----------------------------------------------------------
# START file loading part
# -----------------------------------------------------------
lines = []
file = File.new('exercise_cpp_01.txt', 'r')
while line = file.gets
	lines << line
end
file.close
# -----------------------------------------------------------
# END of the loading part 
# -----------------------------------------------------------


# -----------------------------------------------------------
# START interpreter part
# -----------------------------------------------------------

# initialisation part 
@vars = {}
@hash = {}
@bloc = '}'

def DEBUG (line)
	puts 'DEBUG : '+line
end

# set into the global hash a new variable
def setVars(line)
	variableName = line.scan(/\w+/)[1]
	variableValue = line.scan(/\w+/)[2]
	@vars[variableName] = variableValue.to_f
	
	# DEBUG "set variable "+variableName
end

# check if the variable is still declared, else return the parameter
def convertToVar (variableName)
	for key in @vars.keys
		if key == variableName
			return @vars[key]
		end
	end
end

def ifStatement(line)
	operator = line.scan(/[<>=]=?/)[0]
	numbers = line.scan(/\w+/)[1,3] # remove the if and get only numbers or vars

	numbers[0] = numbers[0].to_f if numbers[0] =~ /\d+/
	numbers[1] = numbers[1].to_f if numbers[1] =~ /\d+/
	
	# if it's variable names, then change it to get the real variable 
	if numbers[0].is_a? String #should change but for the moment still use this work around
		numbers[0] = convertToVar numbers[0] 
	end
	
	return numbers[0] >  numbers[1] if operator == '>'
	return numbers[0] >= numbers[1] if operator == '>='
  return numbers[0] <  numbers[1] if operator == '<'
  return numbers[0] <= numbers[1] if operator == '<='
  return numbers[0] == numbers[1] if operator == '=='
	
end

def printf(line)
	puts line.scan(/["](.*?)["]/)
end

@hash[/\w+ *= *\d+/] = method(:setVars)
@hash[/if *\( *\w+ *[<>=]=? *\w+ *\)/] = method(:ifStatement)
@hash[/printf *\(['"].*["']\) *;/] = method(:printf)

# -----------------------------------------------------------
# END interpreter part
# -----------------------------------------------------------

# works only for one {} we need a counter
@gotoendbloc = false
lines.each { |line|

  # n'évite pas les bloc lors qu'il devrait
  if @gotoendbloc
    if line.match(@bloc)
      @gotoendbloc = false
    end
    next
  end

  @hash.keys.each { |key|
    if key =~ line
      @gotoendbloc = @hash[key].call line

      # maybe we should return or break here
    end

  }
}