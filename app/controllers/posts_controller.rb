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
      redirect_to @post
    else
      flash[:error] = "Invalid title or/and body"
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
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end


  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

end
