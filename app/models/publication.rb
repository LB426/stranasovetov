class Publication < ActiveRecord::Base
  belongs_to :user
  
  validates :title, :text, presence: true

  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images, :reject_if => lambda { |attr| attr[:picture].nil? && attr[:size].nil? && attr[:align].nil? }, :allow_destroy => true
end
