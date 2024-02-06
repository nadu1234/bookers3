class CommentRepliesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book_comment = BookComment.find(params[:book_comment_id])
    @comment_reply = @book_comment.comment_replies.build(comment_reply_params)
    @comment_reply.user = current_user

    if @comment_reply.save
      redirect_to @book_comment.book, notice: '返信が投稿されました。'
    else
      redirect_to @book_comment.book, alert: '返信の投稿に失敗しました。'
    end
  end

  def destroy
    @comment_reply = CommentReply.find(params[:id])
    @comment_reply.destroy
    redirect_to @comment_reply.book_comment.book, notice: '返信が削除されました。'
  end

  private

  def comment_reply_params
    params.require(:comment_reply).permit(:reply)
  end
  
end
  

