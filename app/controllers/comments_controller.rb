class CommentsController < ApplicationController
  before_filter :get_parent
  before_action :comment_find, only: [:edit, :update, :destroy]

  def new
    @comment = @parent.comments.build
  end
 
  def edit

  end


  def create
    @comment = @parent.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to posts_path(@comment), :notice => 'Thank you for your comment!'
    else
      render :new
    end
  end


  def update

    @comment.update(params[:comment].permit(:content))
    
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to posts_path, notice: 'Комментарий обновлен.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy

    @comment.destroy
    redirect_to posts_path
  end
 
  private

  def comment_params
    params.require(:comment).permit(:body, :title, :user_id, :commentable_id, :commentable_type)
  end

  def comment_find
    @comment = Comment.find(params[:id])
  end
   
  def get_parent
    @parent = Post.find_by_id(params[:post_id]) if params[:post_id]
    @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
     
    redirect_to root_path unless defined?(@parent)
  end
end
