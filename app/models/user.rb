class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password
  def self.names
    all.collect {|payment_type| payment_type.name}
  end

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise "不能删除最后一个用户"
    end
  end
end
