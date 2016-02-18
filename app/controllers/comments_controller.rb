class CommentsController < ApplicationController
  before_action :set_comment, only: [:update]
  def update
    @comment.body = params[:body] if params[:body].present?
    @comment.top_position = params[:top_position] if params[:top_position].present?
    @comment.left_position = params[:left_position] if params[:left_position].present?
    @comment.top_offset = params[:top_offset] if params[:top_offset].present?
    @comment.left_offset = params[:left_offset] if params[:left_offset].present?
    @comment.save!
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:name, :body, :top_position, :left_position, :top_offset, :left_offset)
    end

end
