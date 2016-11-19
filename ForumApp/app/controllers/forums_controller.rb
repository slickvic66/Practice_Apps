class ForumsController < ApplicationController
  skip_before_filter :require_login, :only => [:index]

   def new
    @forum = Forum.new()
   end

  def create
    @forum = Forum.new(params[:forum])
    if @forum.save
      flash[:success] = "#{@forum.name} created!"
      redirect_to forum_path(@forum)
    else
      render 'new'
    end
  end

  def index
    @forums = Forum.all
  end

  def show
    @forum = Forum.find(params[:id])
    @conversations = @forum.conversations
  end

  def update
  end

  def edit
  end

  def destroy
  end
end
