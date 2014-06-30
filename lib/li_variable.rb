require_relative 'li_scope'

class LIVariable
  @@all_variables = []

  attr_reader :name,:type,:deep
  attr_accessor :value

  def initialize(name,value,type=:None)
    @@all_variables.each do |v|
      if v.name.to_s == name.to_s
        v.value = value
        return
      end
    end

    @name = name
    @type = type
    @deep = LIScope.actual_deep
    @value = value
    @@all_variables << self
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

    def all_variables
      @@all_variables
    end
  end
end