require "jwt"

class AuthToken
  def self.encode(payload, expiration = 24.hours.from_now)
    payload = payload.dup
    payload["exp"] = expiration.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    HashWithIndifferentAccess.new body
  rescue
    nil
  end
end
