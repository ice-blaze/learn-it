require 'scope'
require 'tools'
class PageController < ApplicationController
  before_action :authenticate_user!, only: :creator

  def home
    @tops = Tutorial.all.sort{|a,b| a.grade_mean <=> b.grade_mean}.reverse
    @newest = Tutorial.order(created_at: :desc)

    Scope::actual_deep

  end

  def creator
  end

  def about
  end
end
