module Concerns::Persistable
  module ClassMethods
    def self.extended(base)
      base.class_variable_set(:@@all, [])
    end

    def destroy_all
      all.clear
    end

    def create(name)
      new(name).tap{|o| o.save}
    end
  end

  module InstanceMethods
    def save
      self.class.all << self
    end
  end
end