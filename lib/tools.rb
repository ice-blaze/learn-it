class Array
  def frequency
    p = Hash.new(0)
    each{ |v| p[v] += 1 }
    p
  end
end

def string_cat(*args)
  result = ''
  args.each do |arg|
    result += ' '+arg.to_s
  end
  result
end