class PostsController < ApplicationController

  def index
    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC").paginate(page:params[:page], per_page: 10)
    else
      @posts = Post.all.order('created_at DESC').paginate(page:params[:page], per_page: 4)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post created"
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = "Post successfully saved"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted"
      redirect_to posts_path
    else
      render 'index'
    end
  end


  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

end
