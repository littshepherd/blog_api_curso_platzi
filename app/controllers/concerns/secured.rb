module Secured
  def authenticate_user!
    # BEARER XXXX
    token_regex = /Bearer (\w+)/
    #leer HEADER de auth
    headers = request.headers
    #verificar que sea valido
      if headers['Authorization'].present? && headers['Authorization'].match(token_regex)
        token = headers['Authorization'].match(token_regex)[1]
        #DEBEMOS VERIFICAR QUE EL TOKEN CORRESPONDA A UN USER
        if (Current.user = User.find_by_auth_token(token))
          return
        end
      end
      render json: {error: 'Unauthorized'}, status: :unauthorized
    end
end