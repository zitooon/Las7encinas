class PictureCategory < ActiveRecord::Base
  has_many :pictures

  validates_presence_of :symbol, :name_en, :name_es, :name_fr
  validates_uniqueness_of :symbol 

  named_scope :ordered, :order => :position

  [:fr, :en, :es].each do |lang|
    define_method "short_name_#{lang}" do
      self.send("name_#{lang}").size > 18 ? self.send("name_#{lang}").first(15)+'...' : self.send("name_#{lang}")
    end
  end

end
