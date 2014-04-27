require_relative 'scope'

class Variable
  @@all_variables = []

  attr_reader :name,:type,:deep
  attr_accessor :value

  def initialize(name,value,type=:None)
    @name = name
    @type = type
    @deep = Scope.actual_deep
    @value = value
    @@all_variables << self
  end

  def self.all_variables
    @@all_variables.clone # return a new deep copy from the array of variables
  end

  def self.clear_variables(deep)
    @@all_variables.delete_if {|item| item.deep >= deep }
  end

  class << self
    def convert(name)
      @@all_variables.each do |item|
        return item.value if item.name.eql? name
      end
    end
  end
end