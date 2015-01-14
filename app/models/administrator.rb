class Administrator < ActiveRecord::Base
  validates_each :name do |model, attr, value|
    if !User.names.include?(value)
      model.errors.add(attr, "无效用户")
    end
  end
end
