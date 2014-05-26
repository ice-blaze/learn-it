class PageController < ApplicationController
  def home
    @tutorials = Tutorial.all
    @interpreters = Interpreter.all
  end

  def creator
  end

  def about
  end
end
