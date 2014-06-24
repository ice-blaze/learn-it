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
    interpreter = Interpreter.find(params[:interpreter_id])
    function = interpreter.functions.create(function_params)
    function.position = interpreter.functions.count
    if function.save
      redirect_to edit_interpreter_path(interpreter)
    else
      redirect_to edit_interpreter_path(interpreter), flash: { error: 'Ouch' }
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

  def up_position
    interpreter = Interpreter.find(params[:interpreter_id])
    function = Function.find(params[:id])

    if function.position == 1
      redirect_to edit_interpreter_path(interpreter), flash: { info: 'Is already at the first !' }
      return
    end

    next_function = Function.where(interpreter: interpreter, position: function.position-1).first
    function.position -= 1
    next_function.position += 1

    if function.save && next_function.save
      redirect_to edit_interpreter_path(interpreter)
    else
      redirect_to edit_interpreter_path(interpreter), flash: { info: 'Position changement failed...' }
    end
  end

  def down_position
    interpreter = Interpreter.find(params[:interpreter_id])
    function = Function.find(params[:id])

    if function.position == interpreter.functions.count
      redirect_to edit_interpreter_path(interpreter), flash: { info: 'Is already the last !' }
      return
    end

    next_function = Function.where(interpreter: interpreter, position: function.position+1).first
    function.position += 1
    next_function.position -= 1

    if function.save && next_function.save
      redirect_to edit_interpreter_path(interpreter)
    else
      redirect_to edit_interpreter_path(interpreter), flash: { info: 'Position changement failed...' }
    end
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
