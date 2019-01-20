module Action
  class Greet < Base
    def handle
      response.write('Hello!')
    end
  end
end
