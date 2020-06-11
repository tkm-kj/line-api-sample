class CallbackController < ApplicationController
  def index
    admin = Admin.find(params[:admin_id])

    # stateが異なっていたら例外を出す
    raise Line::InvalidState unless params[:state] == session[:state]

    line_user_id = Line::Api::Oauth.new(admin).line_user_id(params[:code])
    User.create!(line_user_id: line_user_id)

    render plain: 'LINE連携完了！', status: :ok
  end
end
