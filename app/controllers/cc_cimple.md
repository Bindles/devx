class CommentsController < ApplicationController
  before_action :set_post

  def create
    # rails 8
    # @post.comments.create! params.expect( comment: [ :content ])
    @post.comments.create! params.require(:comment).permit(:content)
    redirect_to @post, notice: 'Comment created'
  end
  
  private
  def set_post
    @post = Post.find(params[:post_id])
  end
  
end
