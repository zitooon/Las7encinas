class Content < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  
  validates_uniqueness_of :symbol, :case_sensitive => false
  
  named_scope :for_symbol, lambda { |c| { :conditions => {:symbol => c.to_s}} }
  
  before_save :clean_back_url   
  
  def self.find_with_options(s, page, order, lang = nil)
    cond = ['']
    if !s.blank?
      rs = "%#{s}%"
      cond[0] << 'contents.title LIKE ? OR contents.symbol LIKE ? '
      cond << rs
      cond << rs
    end 
    self.paginate(:page => page, :per_page => 30, :conditions => cond, :order => order)              
  end
                                                  
  def clean_back_url
    %w(en es fr).each do |lang|
      self.send("text_#{lang}=", self.send("text_#{lang}").gsub(/\"http\:\/\/[\w\.]*\/back\/contents\/[0-9]+\/\$/, '"$'))
    end
  end
  
end
