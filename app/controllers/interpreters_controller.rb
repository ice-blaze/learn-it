class InterpretersController < ApplicationController

  before_action :authenticate_user!, except: :show

  def show
    @interpreter = Interpreter.find(params[:id])
    @function = Function.new
    @functions = @interpreter.functions
    @comment = InterpreterComment.new
    @comments = @interpreter.interpreter_comments

    @grade = @interpreter.interpreter_grades.where(:user_id => current_user.id).first.grade rescue nil
    @grade = 0.0 if @grade.blank?
  end

  def create
    @interpreter = Interpreter.new(interpreter_params)

    @interpreter.version = 1
    @interpreter.user = current_user
    @interpreter.is_finish = false if params[:is_finish].blank?

    if @interpreter.save
      redirect_to @interpreter
    else
      render 'new'
    end
  end

  def new
    @interpreter = Interpreter.new
  end

  def update
    @interpreter = Interpreter.find(params[:id])

    @interpreter.version = @interpreter.version+1

    if @interpreter.update(interpreter_params)
      redirect_to @interpreter
    else
      render 'edit'
    end
  end

  def edit
    @interpreter = Interpreter.find(params[:id])
    @functions = @interpreter.functions
    @function = Function.new
  end

  def delete
  end

  private
  def interpreter_params
    params.require(:interpreter).permit(:title, :description, :is_finish, :open_token, :close_token, :version)
  end
end
