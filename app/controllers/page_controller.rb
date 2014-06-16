require 'scope'
require 'tools'
class PageController < ApplicationController
  before_action :authenticate_user!, only: :creator

  def home
    @tops = Tutorial.where("LOWER(title) LIKE LOWER('%#{params[:top_search]}%')")
    @tops = @tops.sort_by{|a| a.grade_mean }.reverse.paginate(page: params[:top_page], per_page: TUTORIALS_PER_PAGE)
    @newest = Tutorial.where("LOWER(title) LIKE LOWER('%#{params[:recent_search]}%')")
    @newest = @newest.paginate(page: params[:recent_page], per_page: TUTORIALS_PER_PAGE).order(created_at: :desc)

    # render plain: @tops.inspect
    # return

    Scope::actual_deep

  end

  def creator
  end

  def about
  end
end
