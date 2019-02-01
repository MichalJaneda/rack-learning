module Action
  class Greet < Base
    private

    def handle
      response.write('Hello!')
    end
  end
end
