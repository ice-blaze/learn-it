class TutorialsController < ApplicationController
  def index
  end

  def show
    @tutorial = Tutorial.find(params[:id])
    @parts = @tutorial.parts
    @comment = TutorialComment.new
    @comments = @tutorial.tutorial_comments
  end

  def new
    @tutorial = Tutorial.new
  end

  def create
    # render plain: tutorial_params.inspect
    # @interpreters = Interpreter.all
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

  def delete
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :is_finish, :interpreter_id, :tutorial_comment_id, :version)
  end
end
