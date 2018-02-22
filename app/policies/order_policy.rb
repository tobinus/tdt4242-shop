class OrderPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.present? and (@current_user.admin? or @current_user.seller?)
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