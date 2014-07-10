class UsersController < ApplicationController
   # a =.+ before_filter authenticate_admin?, except: :show
  def show
    @user = User.find(params[:id])
    @comments = @user.comments.sort_by{|e| e[:created_at]}.paginate.paginate(page: params[:comments], per_page: USER_DATA_PER_PAGE)

    if current_user != @user
      @tutor_inter = (@user.interpreters+@user.tutorials).paginate.paginate(page: params[:works], per_page: USER_DATA_PER_PAGE)
    else
      unfinished_tut = @user.interpreters.where(is_finish: false)
      unfinished_int = @user.tutorials.where(is_finish: false)
      @unfini_tut_int = (unfinished_int + unfinished_tut).paginate(page: params[:unfini_tut_int], per_page: USER_DATA_PER_PAGE)

      finished_tut = @user.interpreters.where(is_finish: true)
      finished_int = @user.tutorials.where(is_finish: true)
      @fini_tut_int = (finished_int + finished_tut).paginate(page: params[:fini_tut_int], per_page: USER_DATA_PER_PAGE)

      try_tutorials = Tutorial.where(id: Part.where(id: DonePart.where(user: @user).pluck(:part_id)).pluck(:tutorial_id).uniq)
      @try_finish = []
      @try_unfinish = []
      try_tutorials.each do |t|
        if t.done(@user)
          @try_finish << t
        else
          @try_unfinish << t
        end
      end
      @try_unfinish = @try_unfinish.paginate(page: params[:try_unfinish], per_page: USER_DATA_PER_PAGE)
      @try_finish = @try_finish.paginate(page: params[:try_finish], per_page: USER_DATA_PER_PAGE)

      @improve = @user.improve_func_part.paginate(page: params[:improve], per_page: USER_DATA_PER_PAGE)
    end
  end

  def index
    if admin?
      @users = User.where('id != ?', current_user.id)
      @users = @users.where("LOWER(username) LIKE LOWER('%#{params[:search]}%') OR LOWER(email) LIKE LOWER('%#{params[:search]}%')")
      @users = @users.paginate(page: params[:page], per_page: USER_MANAGEMENT_PER_PAGE)
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