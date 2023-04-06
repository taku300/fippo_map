class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def edit
    authorize(@comment)
  end

  def create
    authorize(Comment)

    @comment = current_user.comments.build(comment_params)
    @comment.save
    redirect_to request.referer
  end

  def update
    authorize(@comment)
    if @comment.update(comment_update_params)
      redirect_to request.referer
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@comment)
    @comment.destroy!
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end

  def comment_params
    params.require(:comment).permit(:body).merge(fish_id: params[:fish_id])
  end
end
