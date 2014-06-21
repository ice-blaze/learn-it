class FunctionsController < ApplicationController

  before_action :authenticate_creator!, except: [:show,:create]
  before_action :authenticate_user!, only: :create

  def show
    @interpreter = Interpreter.find(params[:interpreter_id])
    @functions = @interpreter.functions
    @function = Function.find(params[:id])
    @comment = PartComment.new
    @comments =  @function.function_comments.paginate(page: params[:page], per_page: COMMENTS_PER_PAGE).order('created_at DESC')
  end

  def create
    @interpreter = Interpreter.find(params[:interpreter_id])
    function = @interpreter.functions.create(function_params)
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
      redirect_to edit_interpreter_path(interpreter)
    else
      redirect_to edit_interpreter_path(interpreter), flash: { error: 'Ouch' }
    end
  end

  def destroy
    interpreter = Interpreter.find(params[:interpreter_id])
    Function.find(params[:id]).destroy
    redirect_to edit_interpreter_path(interpreter), flash: { error: 'Function deleted' }
  end

  private
  def authenticate_creator!
    interpreter = Function.find(params[:id]).interpreter
    redirect_to root_path unless interpreter.user == current_user || admin?
  end

  def function_params
    params.require(:function).permit(:name, :regex, :content, :description, :interpreter)
  end
end
