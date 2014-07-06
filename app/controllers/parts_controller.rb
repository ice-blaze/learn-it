class PartsController < ApplicationController
  before_action :authenticate_creator!, except: [:show,:create]
  before_action :authenticate_user!, only: :create

  def show
    @output = params[:output].try(:join, "\n").gsub('\n',"\n") rescue nil

    @is_signature = params[:signature]=="true"?true:false
    @tutorial = Tutorial.find(params[:tutorial_id])
    @part = Part.find(params[:id])
    @parts = @tutorial.parts_ordered
    @next_part = @parts[@parts.index(@part)+1]
  end

  def create
    tutorial = Tutorial.find(params[:tutorial_id])
    part = tutorial.parts.create(part_params)
    part.position = tutorial.parts.count

    part.save
    redirect_to edit_tutorial_path(tutorial)
  end

  def update
    tutorial = Tutorial.find(params[:tutorial_id])
    part = Part.find(params[:id])

    if part.update(part_params)
      redirect_to edit_tutorial_path(tutorial)
    else
      render 'edit'
    end
  end

  def destroy
    tutorial = Tutorial.find(params[:tutorial_id])
    Part.find(params[:id]).destroy
    redirect_to edit_tutorial_path(tutorial), flash: { error: 'Part deleted' }
  end

  def up_position
    tutorial = Tutorial.find(params[:tutorial_id])
    part = Part.find(params[:id])

    if part.position == 1
      redirect_to edit_tutorial_path(tutorial), flash: { info: 'Is already at the first !' }
      return
    end

    next_part = Part.where(tutorial: tutorial, position: part.position-1).first
    part.position -= 1
    next_part.position += 1

    if part.save && next_part.save
      redirect_to edit_tutorial_path(tutorial)
    else
      redirect_to edit_tutorial_path(tutorial), flash: { info: 'Position changement failed...' }
    end
  end

  def down_position
    tutorial = Tutorial.find(params[:tutorial_id])
    part = Part.find(params[:id])

    if part.position == tutorial.parts.count
      redirect_to edit_tutorial_path(tutorial), flash: { info: 'Is already the last !' }
      return
    end

    next_part = Part.where(tutorial: tutorial, position: part.position+1).first
    part.position += 1
    next_part.position -= 1

    if part.save && next_part.save
      redirect_to edit_tutorial_path(tutorial)
    else
      redirect_to edit_tutorial_path(tutorial), flash: { info: 'Position changement failed...' }
    end
  end

  private
  def authenticate_creator!
    tutorial = Part.find(params[:id]).tutorial
    redirect_to root_path unless tutorial.user == current_user || admin?
  end

  def part_params
    params.require(:part).permit(:title, :content, :signature, :tutorial)
  end
end
