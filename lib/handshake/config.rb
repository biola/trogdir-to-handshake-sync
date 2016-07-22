module Handshake::Config

  def base_url
    Settings.handshake.url
  end

  def authorization
    { :Authorization => "Token token=\"#{Settings.handshake.token}\"" }
  end

end
