module Line::Api
  class Bot < Base
    delegate :parse_events_from, to: :line_client

    def validate_signature?(body, signature)
      line_client.validate_signature(body, signature)
    end

    private

    def line_client
      @line_client ||= ::Line::Bot::Client.new { |config|
        config.channel_id = @admin.line_messaging_id
        config.channel_secret = @admin.line_messaging_secret
        config.channel_token = @admin.line_messaging_token
      }
    end
  end
end
