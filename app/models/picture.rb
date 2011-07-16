require 'mime/types'

class Picture < ActiveRecord::Base
  belongs_to :picture_category, :foreign_key => :picture_category_id

  cattr_reader :per_page
  @@per_page = 12
  
  has_attached_file :photo,
  :path => ":rails_root/public/images/pictures/:id/:style.:extension",
  :url => "pictures/:id/:style.:extension",
  :styles => {
    :large => "800x600>",
    :medium => "300x360#",
    :thumb => "100x100#"
  }
    
  # Paperclip Validations
  validates_attachment_presence :photo, :message => 'You did not choose a picture to upload.'
  
  named_scope :ordered, :joins => :picture_category, :order => 'picture_categories.position ASC, pictures.id ASC'
  named_scope :from_category, lambda { |c| { :joins => :picture_category, :conditions => {:'picture_categories.symbol' => c.to_s} } }   
  named_scope :random, :order => 'RAND()'
  named_scope :only_in_gallery, :joins => :picture_category, :conditions => "picture_categories.in_gallery = 1"
  
  def self.set_lightbox
    return  "jQuery(function($) {
    	$(\"a[rel^=\'lightbox\']\").slimbox({}, null, function(el) {
    		return (this == el) || ((this.rel.length > 8) && (this.rel == el.rel));
    	});
    });"
  end
end
