module SitemapsHelper
  def authenticity_token_json
    unless protect_against_forgery?
      ''
    else
      %("#{request_forgery_protection_token.to_s}" : "#{form_authenticity_token}",\n)
    end
  end


end

