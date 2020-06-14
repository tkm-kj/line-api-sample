module Line
  class SaveReceivedMessage
    def initialize(admin)
      @admin = admin
    end

    def call(event)
      user = User.find_by(line_user_id: event['source']['userId'])

      Message.create!(sendable: user, receivable: @admin, text: event.message['text']) if user.present?
    end
  end
end
