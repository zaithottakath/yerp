module BusinessesHelper

  def render_tag_links_for(business)
    business.tag_list.map{ |t| link_to t, tag_path(t) }.join(", ")
  end

  def commentor_for(comment)
    user_id = comment.user_id
    user = User.find(user_id)
    user.name || user.email
  end

  def avg_rating_for(business)
    business.rating.round(1)
  end

  def review_count_for(business)
    business.rating_count
  end

end
