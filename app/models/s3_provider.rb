class S3Provider
  attr_accessor :bucket, :access_key_id, :secret_access_key, :key, :content_type,
    :acl, :expiration_date, :max_filesize, :policy, :signature, :form_fields

  def initialize(options = {})
    filename = "#{Rails.root}/config/amazon_s3.yml"
    config = YAML.load_file(filename)

    self.bucket            = config["development"]['bucket']
    self.access_key_id     = config["development"]['access_key_id']
    self.secret_access_key = config["development"]['secret_access_key']
    self.key             = options[:key] || ''
    self.content_type    = options[:content_type] || ''
    self.acl             = options[:acl] || 'public-read'
    self.expiration_date = (options[:expiration_date] || 10.hours).from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z')
    self.max_filesize    = options[:max_filesize] || 500.megabyte

    self.policy = Base64.encode64(
      "{'expiration': '#{self.expiration_date}',
      'conditions': [
      {'bucket': '#{self.bucket}'},
      ['starts-with', '$key', '#{self.key}'],
      {'acl': '#{self.acl}'},
      {'success_action_status': '201'},
      ['content-length-range', 0, #{self.max_filesize}],
      ['starts-with', '$Content-Type', '']
      ]
      }").gsub(/\n|\r/, '')

    self.signature = Base64.encode64(
      OpenSSL::HMAC.digest(
      OpenSSL::Digest::Digest.new('sha1'),
      self.secret_access_key, self.policy)).gsub("\n","")

    self.form_fields = %(
      <form action="#{form_action}" method="post" enctype="multipart/form-data" id="upload-form">
        <input type="hidden" name="key" value="#{self.key}/${filename}">
        <input type="hidden" name="AWSAccessKeyId" value="#{self.access_key_id}">
        <input type="hidden" name="acl" value="#{self.policy}">
        <input type="hidden" name="success_action_redirect" value="http://localhost/">
        <input type="hidden" name="policy" value="#{self.policy}">
        <input type="hidden" name="signature" value="#{self.signature}">
        <input type="hidden" name="Content-Type" value="image/jpeg">
        <input name="file" type="file">
        <input type="submit" value="Upload File to S3">
      </form>
    )
  end
  def form_action
    "https://#{self.bucket}.s3.amazonaws.com/"
  end
  def script_data
    %(
        "AWSAccessKeyId": #{s self.access_key_id},
        "key": #{s self.key},
        "acl": #{s self.acl},
        "policy": #{url_encoded(%("#{self.policy}"), 2)},
        "signature": #{s self.signature}
    )
  end

  def foolbar
     %(<input type="hidden" name="key" value="#{self.key}/${filename}">
        <input type="hidden" name="AWSAccessKeyId" value="#{self.access_key_id}">
        <input type="hidden" name="acl" value="#{self.acl}">
        <input type="hidden" name="policy" value="#{self.policy}">
        <input type="hidden" name="signature" value="#{self.signature}">
        <input type="hidden" name="success_action_status" value="201">
        <input type="hidden" name="Content-Type" value="#{self.content_type}">
        <input name="file" type="file" id="file_input" />
        <input name="submit" value="Upload" type="submit" />)
  end
  private
    def url_encoded(str, num=1)
      str = url_encoded(str) if num==2
      "encodeURIComponent(#{str})"
    end
    def s(str)
      "\"#{str}\""
    end


end

