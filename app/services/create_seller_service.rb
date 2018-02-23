class CreateSellerService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.seller_email) do |user|
      user.password = Rails.application.secrets.seller_password
      user.password_confirmation = Rails.application.secrets.seller_password
      user.confirm
      user.seller!
    end
  end
end