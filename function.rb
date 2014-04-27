class Function
  @@all_functions = []
  @@signature = []
  @@output = []

  attr_reader :regex

  public
  # -----------------
  # static part
  # -----------------

  def self.all_functions
    @@all_functions.clone
  end

  def self.signature
    @@signature.clone
  end

  def self.output(*line)
    @@output<<line.first if line.first.is_a? String
    @@output.clone
  end

  def self.reset_signature_and_output
    @@signature = []
    @@output = []
  end

  def self.default(line)
    raise 'There was no function define for your inputs || line : '+line.inspect
  end

  # -----------------
  # end static part
  # -----------------

  def initialize(regex, function, isSignature=true)
    @regex = regex
    @function = function
    @isSignature = isSignature

    # put the new function on the top of function list
    @@all_functions.unshift self
  end

  def do(line)
    # to save an history, each function calls are stored in an array
    @@signature << @function.name if @isSignature

    @function.call(line)
  end

  # belongs to the static part but need to be at the end of the class
  # because use an instantiation
  Function.new(//,method(:default),false)
end