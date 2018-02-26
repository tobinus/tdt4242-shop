class OrderPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.present?
  end

  def manage?
    @current_user.present? and (@current_user.role == 'admin' or @current_user.role == 'seller')
  end

  def checkout?
    @current_user.present?
  end

  def show?
    @current_user.present?
  end

  def new?
    @current_user.present?
  end

  def create?
    @current_user.present?
  end

  def edit?
    @current_user.present?
  end

  def update?
    @current_user.present?
  end

  def destroy?
    @current_user.present?
  end
end