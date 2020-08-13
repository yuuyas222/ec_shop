class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	#デバイス機能実行前にconfigure_permitted_parametersの実行をする。
	protect_from_forgery with: :exception

	protected

	def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      admins_root_path
    else
      root_path
    end
  end

	#sign_out後のredirect先変更する。
	def after_sign_out_path_for(resource_or_scope)
		if resource_or_scope == :user
			root_path
		elsif resource_or_scope == :admin
			new_admin_session_path
		else
			root_path
		end
	end

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:family_name, :first_name, :family_name_ruby, :first_name_ruby, :email, :tell_number, :postcode, :address])
	#sign_upの際にnameなど追加したカラムの操作を許可する。
	end
end
