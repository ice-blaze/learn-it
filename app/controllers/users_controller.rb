class UsersController < ApplicationController
   # a =.+ before_filter authenticate_admin?, except: :show
  def show
    @user = User.find(params[:id])

    if current_user != @user
      @tutor_inter = @user.interpreters+@user.tutorials
    else
      unfinished_tut = current_user.interpreters.where(is_finish: false)
      unfinished_int = current_user.tutorials.where(is_finish: false)
      @unfini_tut_int = unfinished_int + unfinished_tut

      finished_tut = current_user.interpreters.where(is_finish: true)
      finished_int = current_user.tutorials.where(is_finish: true)
      @fini_tut_int = finished_int + finished_tut

      try_tutorials = Tutorial.where(id: Part.where(id: DonePart.where(user: current_user).pluck(:part_id)).pluck(:tutorial_id).uniq)
      @try_finish = []
      @try_unfinish = []
      try_tutorials.each do |t|
        if t.done(current_user)
          @try_finish << t
        else
          @try_unfinish << t
        end
      end

      parts = Part.where(tutorial: Tutorial.where(user: current_user))
      functions = Function.where(interpreter: Interpreter.where(user: current_user))
      @improve = (parts+functions).sort_by{|e| e.votes.where(positive: true).count-e.votes.where(positive: false).count}
    end
  end

  def index
    if admin?
      @users = User.where('id != ?', current_user.id)
    else
      redirect_to root_path
    end
  end

  def destroy
    if admin?
      @user = User.find(params[:id]).delete
      redirect_to users_path
    else
      redirect_to root_path
    end
  end

  def rise_to_admin
    @user = User.find(params[:id])
    if admin?
      @user = User.find(params[:id])
      @user.admin = true
      @user.save
      redirect_to users_path
    else
      redirect_to root_path
    end
  end
end