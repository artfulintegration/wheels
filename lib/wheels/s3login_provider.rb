class S3loginProvider
  attr_accessor :bucket, :access_key_id, :secret_access_key, :key, :content_type,
    :acl, :expiration_date, :max_filesize, :policy, :signature

  def initialize(options = {})
    filename = "#{Rails.root}/config/amazon_s3.yml"
    config = YAML.load_file(filename)

    self.bucket            = config[ENV["RAILS_ENV"]]['bucket_name']
    self.access_key_id     = config[ENV["RAILS_ENV"]]['access_key_id']
    self.secret_access_key = config[ENV["RAILS_ENV"]]['secret_access_key']

    self.key             = options[:key] || ''
    self.content_type    = options[:content_type] || ''
    self.acl             = options[:acl] || 'public-read'
    self.expiration_date = (options[:expiration_date] || 10.hours).from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z')
    self.max_filesize    = options[:max_filesize] || 500.megabyte

    self.policy = Base64.encode64(
      "{'expiration': '#{expiration_date}',
      'conditions': [
      {'bucket': '#{bucket}'},
      ['starts-with', '$key', '#{key}'],
      {'acl': '#{acl}'},
      {'success_action_status': '201'},
      ['content-length-range', 0, #{max_filesize}],
      ['starts-with', '$Filename', ''],
      ['starts-with', '#{content_type}', '']
      ]
      }").gsub(/\n|\r/, '')

    self.signature = Base64.encode64(
      OpenSSL::HMAC.digest(
      OpenSSL::Digest::Digest.new('sha1'),
      self.secret_access_key, self.policy)).gsub("\n","")

    self.form_fields = %(
      <form action="https://#{bucket}.s3.amazonaws.com/" method="post" enctype="multipart/form-data" id="upload-form">
        <input type="hidden" name="key" value="#{key}/${filename}">
        <input type="hidden" name="AWSAccessKeyId" value="#{access_key_id}">
        <input type="hidden" name="acl" value="#{acl}">
        <input type="hidden" name="policy" value="#{policy}">
        <input type="hidden" name="signature" value="#{signature}">
        <input type="hidden" name="success_action_status" value="201">
        <input type="hidden" name="Content-Type" value="#{content_type}">
        <input name="file" type="file" id="" />
        <input name="submit" value="Upload" type="submit" id="upload_button" />
      </form>
    )
  end
end

