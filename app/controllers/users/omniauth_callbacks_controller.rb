class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController  

  def twitter
    auth = env["omniauth.auth"]
    Rails.logger.info("auth is **************** #{auth.to_yaml}")
    @user = user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.from_omniauth(auth)

    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: 'Twitter'
    sign_in_and_redirect @user, :event => :authentication
  end

end
