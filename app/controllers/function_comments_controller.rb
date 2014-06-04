class FunctionCommentsController < ApplicationController

  before_action :authenticate_member!

  def create
    @interpreter = Interpreter.find(params[:interpreter_id])
    @function = Function.find(params[:function_id])
    @comment = @function.function_comments.create(comment_params)
    @comment.user = current_user
    @comment.like = 0
    @comment.dislike = 0
    if @comment.save
      redirect_to interpreter_function_path(@interpreter,@function)
    else
      redirect_to interpreter_function_path(@interpreter,@function), :flash => { :error => 'Part comment fail' }
    end
  end

  def update

  end

  def index

  end

  private
  def comment_params
    params.require(:function_comment).permit(:content, :function, :user)
  end
end
