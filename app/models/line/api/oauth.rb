module Line::Api
  class Oauth < Base
    include Rails.application.routes.url_helpers

    AUTH_URI = 'https://access.line.me/oauth2/v2.1/authorize'

    def auth_uri(state)
      params = {
        response_type: 'code',
        client_id: @admin.line_login_id,
        redirect_uri: callback_uri,
        state: state,
        scope: 'openid',
        prompt: 'consent', # 必ずLINE認証を許可するようにするオプション
        bot_prompt: 'aggressive' # ログイン後に連携した公式アカウントと友だちになるか聞く画面を出してくれる
      }

      # NOTE: https://developers.line.biz/ja/docs/line-login/integrate-line-login/#making-an-authorization-request
      "#{AUTH_URI}?#{params.to_query}"
    end

    def line_user_id(code)
      verify_id_token(access_token_data(code))['sub']
    end

    private

    def callback_uri
      admin_callback_index_url(@admin.id)
    end

    def access_token_data(code)
      req_body = {
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: callback_uri, # NOTE: LINEログインのチャネルのコンソールで設定した「コールバックURL」と比較している。
        client_id: @admin.line_login_id,
        client_secret: @admin.line_login_secret
      }

      # NOTE: https://developers.line.biz/ja/docs/line-login/integrate-line-login/#get-access-token
      res = conn.post do |req|
        req.url '/oauth2/v2.1/token'
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.body = req_body
      end
      JSON.parse(handle_error(res).body)
    end

    def verify_id_token(access_token_data)
      req_body = {
        id_token: access_token_data['id_token'],
        client_id: @admin.line_login_id
      }
      # NOTE: https://developers.line.biz/ja/reference/social-api/#verify-id-token
      res = conn.post do |req|
        req.url '/oauth2/v2.1/verify'
        req.body = req_body
      end
      JSON.parse(handle_error(res).body)
    end
  end
end
