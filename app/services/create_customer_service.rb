class CreateCustomerService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.customer_email) do |user|
      user.password = Rails.application.secrets.customer_password
      user.password_confirmation = Rails.application.secrets.customer_password
      user.name = 'Customer Name'
      user.confirm
      user.customer!
    end
  end
end