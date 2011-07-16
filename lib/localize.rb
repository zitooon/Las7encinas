module Localize

  module String

    def translate(default = nil, arg = nil, namespace = nil)
      I18n.t self, :scope => :autoscoping, :default => (default || self)
    end
    alias :t :translate

  end

  module Number

    def localize
      defaults = I18n.translate('number.format', :raise => true) rescue {}

      begin
        parts = self.to_s.split('.')
        parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{defaults[:delimiter]}")
        parts.join(defaults[:separator])
      rescue
        self
      end

    end

  end

  module Time

    def localize(format = nil)
      if format
        format = format.gsub('%c', I18n.t('default', :scope => 'date.formats')) rescue format
        return self.strftime(format)
      end

      I18n.l self
    end
  end

end