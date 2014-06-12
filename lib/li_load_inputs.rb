require_relative 'li_function'
require_relative 'scope'
require_relative 'tools'
require_relative 'variable'

def load_inputs inputs
  signature = []
  begin
    for line in inputs
      #if we are in the false jump condition, skip to the output block
      next if Scope::is_token? line
      if Scope::is_jumping?
        next
      end

      #for all lines check if there is a function
      LIFunction.all_functions.each do |function|
        if function.regex =~ line
          unless function.do line
            Scope::start_jump
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