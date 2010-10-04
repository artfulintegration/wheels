Paperclip.interpolates :user_email do |attachment, style|
  attachment.instance.gallery.user.email
end

Paperclip.interpolates :page_id do |attachment, style|
  "page_#{attachment.instance.page_id}"
end

