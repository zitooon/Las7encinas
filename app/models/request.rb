class Request < ActiveRecord::Base

  validate :validate_request

  cattr_reader :per_page
  @@per_page = 10

  def validate_request
    [:full_name, :phone, :email, :company, :message].each do |v|
      if self.send(v) == I18n.t(v)
        self.send(v.to_s+'=', '')
      end
    end      
    self.errors.add(:full_name, true) if self.full_name.empty?
    self.errors.add(:phone, true) if self.phone.empty?
    if self.email.empty? or !(self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i)
      self.errors.add(:email, true)
    end
  end

  def compact_infos
    infos = "\nFull name : " + full_name
    unless company.blank?
      infos << "\nCompany : " + company
    end
    infos << "\nPhone : " + phone 
    infos << "\nEmail : " + email 
    infos << "\nDate : " + created_at.strftime('%D - %R')    
    infos << "\nMessage : " + (message.blank? ? 'No message' : message)
    infos
  end

end
