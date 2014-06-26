require_relative 'li_function'
require_relative 'li_scope'
require_relative 'tools'
require_relative 'li_variable'

def load_inputs inputs
  signature = []
  begin
    index = 0
    max_lines = inputs.size
    while index<max_lines
      line = inputs[index]
      #if we are in the false jump condition, skip to the output block
      next if LIScope::is_token?(line)
      if LIScope::is_jumping?
        next
      end

      #for all lines check if there is a function
      LIFunction.all_functions.each do |function|
        if function.regex =~ line
          result = function.do(line)
          if result == false
            LIScope::start_jump
          elsif result == 'for'
            # set the function line and scope to come back later
          end
          break
        end
      end
    end

    signature = signature + LIFunction.signature
    LIFunction.reset_signature_and_output
    signature
  rescue Exception => e
    e.message
  end
end