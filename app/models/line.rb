module Line
  class ApiError < RuntimeError
    def initialize(msg)
      super(msg)
    end
  end
  class InvalidState < RuntimeError; end
end
