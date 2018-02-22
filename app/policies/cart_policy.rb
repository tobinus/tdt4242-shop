class CartPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.admin?
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