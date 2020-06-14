module Line
  class SaveReceivedMessage
    def initialize(admin)
      @admin = admin
    end

    def call(event)
      user = User.find_by(line_user_id: event['source']['userId'])

      resource = MessageText.new(content: event.message['text'])
      Message.create!(sendable: user, receivable: @admin, resource: resource) if user.present?
    end
  end
end
