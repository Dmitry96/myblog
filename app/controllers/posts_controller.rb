class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
    unless signed_in?
      redirect_to signin_url
    end
  end
 
  def show
    @post = Post.find(params[:id])
  end
 
  def new
    @post = Post.new
  end
   
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, :notice => "Your post was created successfully."
    else
      render :action => :new
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes (post_params)

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Пост обновлен.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to @post
  end

private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
