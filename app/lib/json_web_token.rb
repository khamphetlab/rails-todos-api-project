class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = Rails.application.secrets.secret_key_base
  # @algorithm = 'HS256'

  def self.encode(payload, exp = 24.hours.from_now)
    # set expiry to 24hours from creation now
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET, true, { algorithm: 'HS256' })[0]
    HashWithIndifferentAccess.new body
    # rescue from expiry exception
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    # raise custom error to be handled by custom handler
      raise ExceptionHandler::InvalidToken, e.message
  end
end
