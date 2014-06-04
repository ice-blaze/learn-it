class DonePartsController < ApplicationController

  before_action :authenticate_user!

  def create
    # render plain: done_params.inspect
    @tutorial = Tutorial.find(params[:tutorial_id])
    @part = Part.find(params[:part_id])
    if @part.signature != params[:signature]
      redirect_to [@tutorial,@part], :flash => { :error => 'Signature doesn\'t match, retry !'}
      return
    end


    @done_part = DonePart.new
    @done_part.user = current_user
    @done_part.part = @part
    # no checks in the case where the user try a lot of request and uniquness fail
    @done_part.save

    @parts = @tutorial.parts
    @next_part = @parts[@parts.index(@part)+1]
    redirect_to [@tutorial,@next_part], :flash => { :info => 'Good job you are now in the next part !'}
  end
end
