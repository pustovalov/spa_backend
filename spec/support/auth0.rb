def authenticated_header(user)
  token = Knock::AuthToken.new(payload: { sub: user.id }).token

  request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
end
