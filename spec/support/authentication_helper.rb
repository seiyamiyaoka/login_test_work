module AuthenticationHelper
  def sign_in(user)
    post sessions_path,
    params: {
      session: {
        email: user.email,
        password: user.password
        }
      }
  end
end
