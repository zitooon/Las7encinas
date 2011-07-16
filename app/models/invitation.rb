class Invitation < ActiveRecord::Base
  
  attr_reader :expires_in
  
  cattr_reader :per_page
  @@per_page = 10
  
  
  validate :validate_code
  
  def validate_code
    if self.code.empty?
      self.errors.add(:code, 'Please indicate a code.')
    elsif (t = Invitation.find(:first, :conditions => {:code => self.code})) and t.id != self.id 
      self.errors.add(:code, 'This code is already taken. Please choose another one.')
    end
  end
  
  def generate_code(code_length=8)
      charlist = ("A".."Z").to_a + ("0".."9").to_a
      self.code = Invitation.count(:all).to_s
      1.upto(code_length) { |i| self.code << charlist[rand(charlist.size-1)] }
      self.code
  end
  
  def expires_in=(nb_days)
    self.expires_at = nb_days.to_i.days.from_now
  end
  

end
