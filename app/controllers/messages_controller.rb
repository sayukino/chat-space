class MessagesController < ApplicationController
  def index
  end

  def show
    @group = group.find(params[:id])
    @users = @group.groups_users
    @messages = @group.messages.order("created_at ASC")
  end
  
  def create
    Message.create(create_params)
  end

private
def create_params
  params.require(:message).permit(:body, :image).merge(user_id: current_user.id)
end

end