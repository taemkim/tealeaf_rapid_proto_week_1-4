class CommentsController < ApplicationController

  def create
  	@post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user = User.first #hardcoded, needs to be changed

    if @comment.save
      flash[:notice] = "Comment has been added."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

end