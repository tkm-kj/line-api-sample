module Line::Api
  class Base
    ENDPOINT = 'https://api.line.me'

    def initialize(admin)
      @admin = admin
    end

    private

    def conn
      @conn ||= Faraday.new(url: ENDPOINT)
    end

    def handle_error(res)
      if res.status != 200
        msg = <<~MSG
        status_code: #{res.status}
        body: #{res.body}
        MSG
        raise Line::ApiError, msg
      end

      res
    end
  end
end
