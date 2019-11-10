class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @groups = @user.groups.order("created_at ASC")
  end


  def edit
    @user = User.find(params[:id])
  end

   def update
    user = User.find(params[:id])
    if user.user_id = current_user.id
      user.update(user_params)
    redirect to controller: :messages, action: :index
    end

  private
  def user_params
    params.permit(:user_name, :email)
  end


end
