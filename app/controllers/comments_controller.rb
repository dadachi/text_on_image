class CommentsController < ApplicationController
  before_action :set_comment, only: [:update]
  def update
    @comment.body = params[:body]
    @comment.top_position = params[:top_position]
    @comment.left_position = params[:left_position]
    @comment.top_offset = params[:top_offset]
    @comment.left_offset = params[:left_offset]
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
