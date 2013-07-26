module BusinessesHelper
  include ActsAsTaggableOn::TagsHelper

  def render_tag_links_for(business)
    business.tag_list.map{ |t| link_to t, businesses_path(tag: t) }.join(", ")
  end

  def commentor_for(comment)
    user_id = comment.user_id
    user = User.find(user_id)
    user.name || user.email
  end

  def avg_rating_for(business)
    if business.rating
      business.rating.round(1)
    else
      "No rating"
    end
  end

  def review_count_for(business)
    if business.rating_count
      business.rating_count
    else
      "No ratings"
    end
  end

  def blue_button
    'btn btn-primary'
  end

  def gray_button
    'btn'
  end

  def rand_button
    ['btn-primary', '', 'btn-success', 'btn-warning', 'btn-danger', 'btn-inverse', 'btn-link'].sample
  end
end
