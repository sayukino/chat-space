class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @groups = @user.groups.order("created_at ASC")
  end


  def edit
  end

   def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email)
  end


end
