Paperclip.interpolates :user_email do |attachment, style|
  attachment.instance.gallery.user.email
end

