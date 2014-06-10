class InterpreterCommentVotesController < ApplicationController

  before_action :authenticate_user!

  def create
    @interpreter = Interpreter.find(params[:interpreter_id])
    @comment = InterpreterComment.find(params[:interpreter_comment_id])
    @vote = InterpreterCommentVote.create(vote_params)
    @vote.user = current_user
    @vote.interpreter_comment = @comment

    # no checks in the case where the user try a lot of request and uniquness fail
    @vote.save
    redirect_to @interpreter
  end

  def update
    @vote = InterpreterCommentVote.find(params[:id])
    @interpreter = Interpreter.find(params[:interpreter_id])

    if @vote.update(vote_params)
      redirect_to @interpreter
    else
      redirect_to @interpreter, :flash => { :info => 'Change vote FAILED !' }
    end
  end

  def destroy

  end

  private
  def vote_params
    params.require(:interpreter_comment_vote).permit(:positive)
  end
end
