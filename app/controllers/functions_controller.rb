class FunctionsController < ApplicationController

  before_action :authenticate_user!, except: :show

  def show
    @interpreter = Interpreter.find(params[:interpreter_id])
    @functions = @interpreter.functions
    @function = Function.find(params[:id])
    @comment = PartComment.new
    @comments = @function.function_comments
  end

  def create
    @interpreter = Interpreter.find(params[:interpreter_id])
    @function = @interpreter.functions.create(function_params)
    redirect_to edit_interpreter_path(@interpreter)
  end

  def update
    interpreter = Interpreter.find(params[:interpreter_id])
    function = Function.find(params[:id])

    if function.update(function_params)
      redirect_to edit_interpreter_path(interpreter)
    else
      render 'edit'
    end
  end

  def edit
  end

  def delete
  end

  private
  def function_params
    params.require(:function).permit(:name, :regex, :content, :description, :interpreter)
  end
end
