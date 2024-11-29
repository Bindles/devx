class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where("user1_id = ? OR user2_id = ?", current_user.id, current_user.id)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.order(created_at: :asc)
  end

  def create
    # Find the user to message
    recipient = User.find(params[:user_id])
  
    # Find or create a conversation between current_user and the recipient
    conversation = Conversation.between(current_user, recipient) || Conversation.create(user1: current_user, user2: recipient)
  
    # Redirect to the conversation show page
    redirect_to conversation_path(conversation)
  end
  
end
