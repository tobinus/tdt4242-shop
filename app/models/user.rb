class User < ApplicationRecord
  enum role: [:customer, :seller, :admin]
  has_one :cart
  has_many :orders
  after_initialize :set_default_role, :if => :new_record?
  after_create :create_cart

  def set_default_role
    self.role ||= :customer
  end

  def create_cart
    @cart = Cart.create(user_id: id)
    self.cart_id = @cart.id
    save
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
