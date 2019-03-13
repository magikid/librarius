Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, ENV['GH_CLIENT_ID'], ENV['GH_CLIENT_SECRET']
  end
