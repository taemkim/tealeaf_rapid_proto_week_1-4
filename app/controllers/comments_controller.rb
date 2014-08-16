class CommentsController < ApplicationController
  before_action :require_user

  def create
  	@post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment has been added."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find(params[:id])
    vote = Vote.create(voteable: comment, user: current_user, vote: params[:vote])
    
    if vote.valid?
      flash[:notice] = "Vote made."
    else
      flash[:error] = "You can only vote on a comment once."
    end
    redirect_to :back
  end
end