class WebhookController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    admin = Admin.find(params[:admin_id])

    bot = Line::Api::Bot.new(admin)
    body = request.body.read
    raise Line::InvalidSignatureError unless bot.validate_signature?(body, request.env['HTTP_X_LINE_SIGNATURE'])

    events = bot.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        Line::SaveReceivedMessage.new(admin).call(event)
      end
    end

    render plain: 'success!', status: :ok
  end
end
