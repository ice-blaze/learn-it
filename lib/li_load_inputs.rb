require_relative 'li_function'
require_relative 'li_scope'
require_relative 'tools'
require_relative 'li_variable'

def load_inputs inputs
  LIFunction.reset_signature_and_output
  LIVariable.clear_variables(0)

  begin
    index_line = 0
    max_lines = inputs.size
    while index_line<max_lines
      line = inputs[index_line]
      index_line += 1

      next if LIScope::is_open_token?(line) # open token, do nothing
      if LIScope::is_close_token?(line) # close token and got a loop, go to the start of the loop
        last_loop = LIScope::pop_loop
        index_line = last_loop.line unless last_loop.nil?
        next
      end
      if LIScope::is_jumping?
        next
      end

      #for all lines check if there is a function
      LIFunction.all_functions.each do |function|
        if function.regex =~ line
          result = function.do(line)
          if result == false
            LIScope::start_jump
          elsif function.loop
            LIScope::save_loop(index_line-1)
            # set the function line and scope to come back later
          end
          break
        end
      end
    end

    {signature: LIFunction.signature, output: LIFunction.output(nil)}
  rescue Exception => e
    {signature: e.backtrace.append(e.message), output: e.backtrace.append(e.message)}
    # {signature: e.message, output: e.message}
  end
end