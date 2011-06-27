ActiveAdmin.register Post do
  filter :title
  filter :body
  filter :created_at
  filter :updated_at
  
  index do
    column :title do |post|
      link_to post.title, admin_post_path(post)
    end
    column :created_at
    column :updated_at
  end
  
  form :html => { :multipart => true } do |f|
    f.inputs 'Post Details' do
      f.input :title
      f.input :body, :as => :text
      f.input :image, :as => :file
    end
    f.buttons
  end
  
##  show do
##    div do
##    h3 post.title
##    div do
##      simple_format post.body
##    end
##    end
##  end
end
