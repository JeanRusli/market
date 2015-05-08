class Roast < ActiveRecord::Base
	extend FriendlyId
    friendly_id :name, use: :slugged

	belongs_to :user
	has_attached_file :image
	
	has_many :sales
	
	validates_attachment_content_type :image,
	content_type: /^image\/(png|gif|jpeg)/,
	message: "Only images allowed"
	
	validates :image, attachment_presence: true
	
	has_many :order_items

    default_scope { where(available: true) }
end
