class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = paginate_custom(current_user.feed, params)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
