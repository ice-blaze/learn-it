class InterpreterCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @interpreter = Interpreter.find(params[:interpreter_id])
    @comment = @interpreter.interpreter_comments.create(comment_params)
    @comment.user = current_user
    @comment.like = 0
    @comment.dislike = 0
    if @comment.save
      redirect_to interpreter_path(@interpreter)
    else
      redirect_to interpreter_path(@interpreter), :flash => { :error => 'Interpreter comment fail' }
    end
  end

  def update

  end

  def destroy
    InterpreterComment.find(params[:id]).destroy
    redirect_to :back, flash: { info: 'Comment deleted' }
  end

  private
  def comment_params
    params.require(:interpreter_comment).permit(:content, :interpreter, :user)
  end
end
