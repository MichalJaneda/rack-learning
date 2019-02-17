ValidationPost = Dry::Validation.Schema(AppSchema) do
  required(:title).filled(unique?: :title,
                          max_size?: 256)
  required(:body).filled
end
