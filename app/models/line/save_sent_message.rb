module Line
  class SaveSentMessage
    def initialize(admin)
      @admin = admin
    end

    def call_with_text(user:, text:)
      user = User.find_by(line_user_id: user.line_user_id)

      if user.present?
        Line::Api::Push.new(@admin).call_with_text(user: user, text: text)
        resource = MessageText.new(content: text)
        Message.create!(sendable: @admin, receivable: user, resource: resource)
      end
    end
  end
end
