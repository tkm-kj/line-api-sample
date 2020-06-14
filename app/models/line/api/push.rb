module Line::Api
  class Push < Base
    def call_with_text(user:, text:)
      call(user: user, resource: Message::Text.new([text]))
    end

    private

    def call(user:, resource:)
      req_body = {to: user.line_user_id}.merge(resource.request_body)
      # NOTE: https://developers.line.biz/ja/reference/messaging-api/#send-push-message
      res = conn.post do |req|
        req.url '/v2/bot/message/push'
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = "Bearer #{@admin.line_messaging_token}"
        req.body = req_body.to_json
      end

      handle_error(res)
    end
  end
end
