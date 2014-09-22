class PostsController < ApplicationController

  before_action :checks_is_admin, except: [:index, :show] 
  before_action :find_post,       only:   [:show, :edit, :update, :destroy]

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
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post successfully saved"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Post deleted"
      redirect_to posts_path
    else
      render 'index'
    end
  end

  def find_post
    @post = Post.find(params[:id])
  end


  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

end
