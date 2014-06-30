 'li_variable'

class LILoop
  attr_accessor :line
  attr_accessor :deep

  def initialize(line,deep)
    @line = line
    @deep = deep
  end
end

class LIScope
  @@actual_deep = 0
  @@is_jumping = false
  @@jump_deep = 0

  @@open_token = nil
  @@close_token = nil

  @@loops_list = []

  def self.reset
    @@actual_deep = 0
    @@is_jumping = false
    @@jump_deep = 0
    @@loops_list = []
  end

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

  def self.pop_loop
    return @@loops_list.pop if @@actual_deep == @@loops_list.last.deep rescue nil
    nil
  end

  def self.is_close_token?(line)
    if @@close_token.match(line)
      self.go_back
      @@is_jumping = false if @@actual_deep == @@jump_deep  # prevent when there are close tokens but we aren't on the good depth
      return true
    end
    false
  end

  def self.is_open_token?(line)
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
      LIVariable.clear_variables(@@actual_deep)
      # check if we aren't under 0 depth
      @@actual_deep -= 1
    end
    true
  end

  def self.save_loop(line_number)
    # maybe actual deep should be lower or higher for the save loop function
    @@loops_list.push(LILoop.new(line_number,@@actual_deep))
  end

  private
  # could be better with a before_filter but include to implement
  # a big class
  def self.check_set_tokens
    raise 'no token was set' if @@open_token.nil?
    raise 'no token was set' if @@close_token.nil?
  end
end