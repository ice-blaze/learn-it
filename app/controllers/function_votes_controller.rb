class FunctionVotesController < ApplicationController
  def create
    @interpreter = Interpreter.find(params[:interpreter_id])
    @function = Function.find(params[:function_id])
    @vote = FunctionVote.create(vote_params)
    @vote.user = current_user
    @vote.function = @function

    # no checks in the case where the user try a lot of request and uniquness fail
    @vote.save
    redirect_to [@interpreter,@function]
  end

  def update
    @vote = FunctionVote.find(params[:id])
    @interpreter = Interpreter.find(params[:interpreter_id])
    @function = Function.find(params[:function_id])

    if @vote.update(vote_params)
      redirect_to [@interpreter,@function]
    else
      redirect_to [@interpreter,@function], :flash => { :info => 'Change vote FAILED !' }
    end
  end

  def destroy

  end

  private
  def vote_params
    params.require(:function_vote).permit(:positive)
  end
end
