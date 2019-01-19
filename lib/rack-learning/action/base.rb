module Action
  class Base
    def call(env)
      raise NotImplementedError
    end
  end
end
