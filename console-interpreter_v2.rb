require_relative 'tools'
require_relative 'file_manager'
require_relative 'function'
require_relative 'scope'
require_relative 'variable'
require_relative 'functions/function_data'

Scope::set_tokens(/{/, /}/)

def load_inputs(inputs_path)
  for line in FileManager::load_inputs inputs_path
    #if we are in the false jump condition, skip to the output block
    next if Scope::do line
    if Scope::jump
      next
    end

    #for all lines check if there is a function
    Function.all_functions.each do |function|
      if function.regex =~ line
        unless function.do line
          Scope::start_jump
        end
        break
      end
    end
  end
  
  signature = Function.signature
  Function.reset_signature_and_output
  signature
end

parts_files = Dir.entries('parts').reject{|entry| entry =~ /^\.{1,2}$/}
parts_files = parts_files.map {|item| item = './parts/' + item}
inputs_file_path = './inputs.txt'

puts '------------------------------------'
puts '| Welcom to the Learn-it prototype |'
puts '------------------------------------'
puts
puts 'The inputs are in ./inputs.txt ? (y/n)'
choice = gets.chomp
if choice == 'n'
  puts 'Insert the inputs file please (be careful with the path):'
  inputs_file_path = gets.chomp
end
puts 'Which file compared (insert number):'
parts_files.each_with_index { |item, index | puts '(' + index.to_s + ') ' + item}
choice = gets.chomp
solution_file_path = parts_files[choice.to_i]

# puts ar.inspect

signature1 = load_inputs(inputs_file_path)
signature2 = load_inputs(solution_file_path)

if signature2.frequency == signature1.frequency
  puts 'The inputs fetch with the solution, WELL DONE !!'
else
  puts 'The inputs FAILED with the solution...'
end
