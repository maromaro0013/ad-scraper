class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google
    @user = User.find_for_google(request.env['omniauth.auth'])

    if @user.is_a?(User)
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    elsif @user.is_a?(String)
      flash[:error] = I18n.t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: @user
      redirect_to "/"
    else
      flash[:error] = I18n.t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: 'Email address is must be owned innova.inc.'
      redirect_to "/"
    end
  end
end
