require 'li_scope'
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

    LIScope::actual_deep

  end

  def creator
    @tutorials = []
    @tutorials = Tutorial.where("LOWER(title) LIKE LOWER('%#{params[:tutorial_search]}%')") unless params[:tutorial_search].blank?
    @tutorials = @tutorials.paginate(page: params[:tutorial_page], per_page: TUTORIALS_PER_PAGE)
    @interpreters = []
    @interpreters = Interpreter.where("LOWER(title) LIKE LOWER('%#{params[:interpreter_search]}%')") unless params[:interpreter_search].blank?
    @interpreters = @interpreters.paginate(page: params[:interpreter_page], per_page: TUTORIALS_PER_PAGE)
  end

  def about
  end
end
