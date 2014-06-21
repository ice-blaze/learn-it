class TutorialsController < ApplicationController
  before_action :authenticate_creator!, except: [:show,:new,:create]
  before_action :authenticate_user!, only: [:new,:create]

  def show
    @tutorial = Tutorial.find(params[:id])
    @grade = @tutorial.tutorial_grades.where(user_id: current_user.id).first.grade rescue nil
    @grade = 0.0 if @grade.blank?
    @comments = @tutorial.tutorial_comments.paginate(page: params[:page], per_page: COMMENTS_PER_PAGE).order('created_at DESC')
  end

  def new
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)

    @tutorial.user = current_user
    @tutorial.is_finish = true
    @tutorial.version = 1
    if @tutorial.save
      redirect_to edit_tutorial_path(@tutorial)
    else
      render 'new'
    end
  end

  def edit
    @tutorial = Tutorial.find params[:id]
    @parts = @tutorial.parts_ordered
    @part = Part.new
  end

  def update
    @tutorial = Tutorial.find(params[:id])

    @tutorial.version = @tutorial.version+1

    if @tutorial.update(tutorial_params)
      redirect_to edit_tutorial_path(@tutorial)
    else
      render 'edit'
    end
  end

  def destroy
    Tutorial.find(params[:id]).destroy
    redirect_to root_path, flash: { info: 'Tutorial deleted' }
  end

  private
  def authenticate_creator!
    tutorial = Tutorial.find(params[:id])
    redirect_to root_path unless tutorial.user == current_user || admin?
  end

  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :is_finish, :interpreter_id, :tutorial_comment_id, :version)
  end
end
