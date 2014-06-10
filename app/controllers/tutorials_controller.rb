class TutorialsController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @tutorial = Tutorial.find(params[:id])
    @grade = @tutorial.tutorial_grades.where(:user_id => current_user.id).first.grade rescue nil
    @grade = 0.0 if @grade.blank?
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
    @parts = @tutorial.parts
    @part = Part.new

    #redirect if id doesnt exist
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
  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :is_finish, :interpreter_id, :tutorial_comment_id, :version)
  end
end
