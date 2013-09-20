class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :publication
  has_attached_file :picture, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/pics/:id/:style/:basename.:extension",
                    :url  => "/pics/:id/:style/:basename.:extension",
                    :default_url => "/pics/noimages.png"
end
