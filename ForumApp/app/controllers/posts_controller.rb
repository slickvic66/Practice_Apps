class PostsController < ApplicationController
  def new
    @post = Post.new
    @post.user_id = cookies[:token]
    @post.conversation_id = params[:conversation_id]
    @conversation = Conversation.find(params[:conversation_id])
    @forum = Forum.find(@conversation.forum_id)
  end

  def create
    @post = Post.new(params[:post])
    @conversation = Conversation.find(@post.conversation_id)
    @forum = Forum.find(@conversation.forum_id)
    if @post.save
      flash[:success] = "Post saved"
      redirect_to conversation_path(@post.conversation_id)
    else
      render "new"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to conversation_path(@post.conversation_id)
  end
end
