class TutorialCommentVotesController < ApplicationController
  def create
    @tutorial = Tutorial.find(params[:tutorial_id])
    @comment = TutorialComment.find(params[:tutorial_comment_id])
    @vote = TutorialCommentVote.create(vote_params)
    @vote.user = current_user
    @vote.tutorial_comment = @comment

    # no checks in the case where the user try a lot of request and uniquness fail
    @vote.save
    redirect_to @tutorial
  end

  def update
    @vote = TutorialCommentVote.find(params[:id])
    @tutorial = Tutorial.find(params[:tutorial_id])

    if @vote.update(vote_params)
      redirect_to @tutorial
    else
      redirect_to @tutorial, :flash => { :info => 'Change vote FAILED !' }
    end
  end

  def destroy

  end

  private
  def vote_params
    params.require(:tutorial_comment_vote).permit(:positive)
  end
end
