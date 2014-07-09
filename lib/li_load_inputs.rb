require_relative 'li_function'
require_relative 'li_scope'
require_relative 'tools'
require_relative 'li_variable'

def default(line)
  raise 'There was no function define for your inputs || line : '+line.inspect
end


def load_inputs inputs, functions, open_token, close_token
  LIFunction.reset_signature_and_output
  LIVariable.clear_variables(0)
  LIFunction.reset_functions
  LIScope.reset
  LIFunction.new(//,method('default'),false,false)

  functions.each do |f|
    #thread is there to limit eval abuse
    eval("def #{f.name}(line)
          thread = Thread.start {
            $SAFE = 3
            begin
              Timeout::timeout(0.5) {
                #{f.content}
              }
            rescue Timeout::Error
              raise '#{f.name} take more than 0.5 seconds to execute'
            end
          }
          thread.join
          thread[:return]
        end")
    LIFunction.new(Regexp.new(f.regex),method(f.name),f.signature,f.loop).taint
  end

  # set token
  LIScope::set_tokens(Regexp.new(open_token), Regexp.new(close_token))

  # remove empty lines
  inputs.reject! { |c| c.empty? }

  # begin
  index_line = 0
  max_lines = inputs.size
  start_time = Time.now
  while index_line<max_lines
    raise 'Process time take more than 2 seconds. Possible cause, loop always returning true.' if start_time.to_i+2<Time.now.to_i

    line = inputs[index_line]
    index_line += 1

    next if LIScope::is_open_token?(line) # open token, do nothing
    if LIScope::is_close_token?(line) # close token and got a loop, go to the start of the loop
      last_loop = LIScope::pop_loop
      index_line = last_loop.line unless last_loop.nil?
      next
    end

    next if LIScope::is_jumping?

    #for all lines check if there is a function
    LIFunction.all_functions.each do |function|
      if function.regex =~ line
        result = function.do(line)
        if result == false
          LIScope::start_jump
        elsif function.loop
          LIScope::save_loop(index_line-1)
        end
        break
      end
    end
  end

  {signature: LIFunction.signature, output: LIFunction.output(nil)}
  # rescue Exception => e
  #   # {signature: e.backtrace.append(e.message), output: e.backtrace.append(e.message)}
  #   {signature: e.message, output: e.message}
  # end
end