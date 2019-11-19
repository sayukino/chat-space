class GroupsController < ApplicationController
  def index
  end
  
  def new
    @group = Group.new
    @group.users << current_user
  end 


  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
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
    params.require(:group).permit(:name, user_ids: [] )
  end
end
