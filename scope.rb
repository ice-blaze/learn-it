require_relative 'variable'

class Scope
  @@actual_deep = 0
  @@is_jumping = false
  @@jump_deep = 0

  @@open_token = nil
  @@close_token = nil

  def self.set_tokens( open, close)
    @@open_token = open
    @@close_token = close
  end

  def self.actual_deep
    @@actual_deep
  end

  def self.is_jumping?
    @@is_jumping
  end

  def self.is_token?(line)
    if @@close_token.match(line)
      self.go_back
      @@is_jumping = false if @@actual_deep == @@jump_deep  # prevent when there are close tokens but we aren't on the good depth
      return true
    end

    if @@open_token.match(line)
      self.go_deeper
      return true
    end

    false
  end

  def self.start_jump
    @@jump_deep = @@actual_deep
    @@is_jumping = true
  end

  def self.go_deeper
    @@actual_deep += 1
  end

  def self.go_back
    if @@actual_deep > 0
      Variable.clear_variables(@@actual_deep)
      # check if we aren't under 0 depth
      @@actual_deep -= 1
    end
    true
  end

  private
  # could be better with a before_filter but include to implement
  # a big class
  def self.check_set_tokens
    raise 'no token was set' if @@open_token.nil?
    raise 'no token was set' if @@close_token.nil?
  end
end


# should transform this class into somethin like this
# class A
#   @ololo = 1
#   class << self
#     attr_accessor :ololo
#   end
# end
