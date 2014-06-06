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
    function = @interpreter.functions.create(function_params)
    # function.content = function.content.gsub(/\\/, '\\\\')
    if function.save
      redirect_to edit_interpreter_path(@interpreter)
    else
      redirect_to edit_interpreter_path(@interpreter), flash: { error: 'Ouch' }
    end
  end

  def update
    interpreter = Interpreter.find(params[:interpreter_id])
    function = Function.find(params[:id])
    if function.update(function_params)
      # function.content = function.content.gsub(/\\/, '\\\\')
      redirect_to edit_interpreter_path(interpreter)
    else
      redirect_to edit_interpreter_path(interpreter), flash: { error: 'Ouch' }
    end
  end

  def edit
  end

  def destroy
    interpreter = Interpreter.find(params[:interpreter_id])
    Function.find(params[:id]).destroy
    redirect_to edit_interpreter_path(interpreter), flash: { error: 'Function deleted' }
  end

  private
  def function_params
    params.require(:function).permit(:name, :regex, :content, :description, :interpreter)
  end
end
