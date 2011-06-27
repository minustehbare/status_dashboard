class Post < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 5
  
  has_attached_file :image, :styles => { :mini => '48x48>', :thumbnail => '256x256>', :homepage => '1000x1000>' }
  
end
