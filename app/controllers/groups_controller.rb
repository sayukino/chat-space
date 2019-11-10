class GroupsController < ApplicationController
  
  def new
    @group = Group.new
    @user = User.find_by(user_id = current_user.id)
    @users = User.find(params[:id])
    @users << @user
    @group.users.new
  end 


  
  def create
  @group = Group.new(group_params)
  if @group.save
   redirect_to controller: :messages, action: :index
   flash[:success] = 'グループを作成しました'
  else
   render 'new'
 end
end

  def show
    @users = group.groups_users
  end

  def delete
    @users = group.groups_users
    @user = @users.find(params[:id])
    @user.delete unless @user = current_user
  end

 
  def edit
    @group = Group.find(params[:id])
  end

  def update
    group = Group.find(params[:id])
    if group.user.user_id == current_user.id
      group.update(group_params)
       if group.update
        redirect_to controller: :messages, action: :show
        flash[:update_success] = 'グループを編集しました'
       else
        render 'edit'
      end
    end
  end

  private
  def group_params
    params.require(:group).permit(:group_name, { :user_ids=> [] })
end

end
