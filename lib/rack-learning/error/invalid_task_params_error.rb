class InvalidTaskParamsError < Exception
  def initialize(param)
    super("#{param} missing")
  end
end
