class ConversationsController < ApplicationController
  def new
    @conversation = Conversation.new
    @conversation.user_id = cookies[:token]
    @conversation.forum_id = params[:forum_id]

    @conversation.posts.build
  end

  def create
    @conversation = Conversation.new(params[:conversation])
    if @conversation.save
      flash[:sucess] = "Thread created successfully!"
      redirect_to conversation_path(@conversation)
    else
      render 'new'
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @posts = @conversation.posts
  end
end
