class LIFunction
  @@all_functions = []
  @@signatures = []
  @@output = []

  attr_reader :regex
  attr_reader :function
  attr_reader :loop
  attr_reader :is_signature

  public
  # -----------------
  # static part
  # -----------------

  def self.all_functions
    @@all_functions.clone
  end

  def self.signature
    @@signatures.clone
  end

  def self.output(line)
    @@output<<line if line.is_a? String
    @@output.clone
  end

  def self.reset_signature_and_output
    @@signatures = []
    @@output = []
  end

  def self.reset_functions
    @@all_functions = []
  end

  # -----------------
  # end static part
  # -----------------

  def initialize(regex, function, is_signature=true, loop=false)
    @regex = regex
    @function = function
    @is_signature = is_signature
    @loop = loop

    # put the new function on the top of function list
    @@all_functions.unshift self
  end

  def do(line)
    # to save an history, each function calls are stored in an array

    @@signatures << @function.name if @is_signature
    @function.call(line)
  end

  # belongs to the static part but need to be at the end of the class
  # because use an instantiation
end