class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Post created"
    else
      flash[:error] = "Sign in please"
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if (@comment.user == current_user) || current_user.admin?
      @comment.destroy
    else
      flash[:error] = "Access denied"
    end

    redirect_to post_path(@post)
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
