class ProductPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def new?
    @current_user.admin? or @current_user.seller?
  end

  def manage?
    @current_user.admin? or @current_user.seller?
  end

  def create?
    @current_user.admin? or @current_user.seller?
  end

  def edit?
    @current_user.admin? or @current_user.seller?
  end

  def update?
    @current_user.admin? or @current_user.seller?
  end

  def destroy?
    @current_user.admin? or @current_user.seller?
  end
end