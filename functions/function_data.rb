require_relative '../function'

def init_vars_func(line)
  # Miss the type management
  variable_name = line.scan(/\w+/)[1]
  variable_value = line.scan(/\w+/)[2]
  Variable.new(variable_name,variable_value.to_f)
  true
end
INIT = Function.new(/\w+ *= *\d+/,method(:init_vars_func))

def if_statement(line)
  operator = line.scan(/[<>=]=?/)[0]
  numbers = line.scan(/\w+/)[1,3] # remove the if and get only numbers or vars

  numbers[0] = numbers[0].to_f if numbers[0] =~ /\d+/
  numbers[1] = numbers[1].to_f if numbers[1] =~ /\d+/

  # if it's variable names, then change it to get the real variable
  if numbers[0].is_a? String #should change but for the moment still use this work around
    numbers[0] = Variable.convert numbers[0]
  end
  if numbers[1].is_a? String #should change but for the moment still use this work around
    numbers[1] = Variable.convert numbers[1]
  end

  #puts numbers[0].inspect + " " +numbers[1].inspect
  return numbers[0] >= numbers[1] if operator == '>='
  return numbers[0] <  numbers[1] if operator == '<'
  return numbers[0] <= numbers[1] if operator == '<='
  return numbers[0] == numbers[1] if operator == '=='
  numbers[0] >  numbers[1] if operator == '>'
end
Function.new(/if *\( *\w+ *[<>=]=? *\w+ *\)/,method(:if_statement))

def printf_func(line)
  Function.output line.scan(/["](.*?)["]/).first.first # maybe dangerous
  true
end
Function.new(/printf *\(['"].*["']\) *;/,method(:printf_func))

# empty line
def nothing_func(line)
  line
  true
end
Function.new(/^ *\n$/,method(:nothing_func),false)
