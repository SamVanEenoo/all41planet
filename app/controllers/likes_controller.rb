class LikesController < ApplicationController

  def index
    article_id = params[:article_id]
    @article = Article.find article_id
    if current_user
      like = Like.find_or_initialize_by(article_id: article_id, user_id: current_user.id)
      if like.new_record?
        like.save
      else
        like.destroy
      end
    end
  end

end
