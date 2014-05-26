class FunctionsController < ApplicationController
  def show
  end

  def create
    @interpreter = Interpreter.find(params[:interpreter_id])
    @function = @interpreter.functions.create(function_params)
    redirect_to edit_interpreter_path(@interpreter)
  end

  def edit
  end

  def delete
  end

  private
  def function_params
    params.require(:function).permit(:name, :regex, :content, :interpreter)
  end
end
