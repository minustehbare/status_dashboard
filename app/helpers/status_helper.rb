require 'rdiscount'

module StatusHelper
  
  def post_body_to_html(post)
    raw RDiscount.new(post.body).to_html
  end
  
end
