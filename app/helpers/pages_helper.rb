module PagesHelper
  def form_url
    @parent_page ? page_children_path(@parent_page) : page_path(@page)
  end
  def form_object
    @parent_page ? [@parent_page, @page] : @page
  end

  def to_html_options(pages)
    pages.map{|p| [p.title, p.id]}
  end

  ######################################################
  ##
  ##
  ##   Begin of uploadify_s3
  ##
  ##
  ######################################################

  def uploadify_s3(options = {})
#    stylesheet_link_tag('uploadify/uploadify') <<
#    javascript_include_tag('uploadify/jquery.uploadify.v2.1.0.min') <<
#    javascript_include_tag('uploadify/swfobject') <<
    javascript_uploadify_s3_tag(options)
  end

  protected

  def javascript_uploadify_s3_tag(options = {})
    options = default_options.merge(options)
    javascript_tag( %(
  		$(document).ready(function() {
  			$("#{options[:file_input_selector]}").uploadify({
  				'fileDataName' : 'file',
  				'uploader'       : '/uploadify.swf',
  				'script'         : '#{bucket_url}',
  				'cancelImg'      : '/images/uploadify/cancel.png',
  				'folder'         : 'attachments',
  				'auto'           : true,
  				'multi'          : true,
  				'buttonText'		 : 'Add File',
  				'sizeLimit'			 : '#{max_filesize}',
  				'fileDesc'		   : '#{options[:file_desc]}',
  				'fileExt'				 : '#{options[:file_ext]}',
  				'onSelect'       : function(event, queueID, fileObj) {
  				    if (fileObj.size >= "#{max_filesize}") {
      					$("#{options[:file_input_selector]}").uploadifyCancel(queueID);
      					alert('Sorry the max file size is #{((max_filesize/1024)/1024)} MB');
      					return false;
      				}

              $('div.button_group').hide();
              return true;
  				},
  				'onComplete'     : function(event, queueID, fileObj, response) {
            $('div.button_group').show();
            fileInfo = {
					    'name' : fileObj.name,
					    'size' : fileObj.size,
					    'type' : fileObj.type,
					    'url'  : '#{bucket_url}#{upload_path}/' + fileObj.name + '#{rangen}'
					  };
					  var onsucc = (#{options[:on_success]});
					  onsucc(fileInfo);
						$('#{options[:file_input_selector]}').hide();
						return true;
  				},
  				'onError' 			 : function (a, b, c, d) {
  					if (d.info == 201) {
  					  fileInfo = {
  					    'name' : c.name,
  					    'size' : c.size,
  					    'type' : c.type,
  					    'url'  : '#{bucket_url}#{upload_path}/' + c.name + '#{rangen}'
  					  };
  					  var onsucc = (#{options[:on_success]});
  					  onsucc(fileInfo);
  						$('#{options[:file_input_selector]}').hide();
  					} else {
              var onerror = (#{options[:on_error]});
              if (onerror) {
                onerror(d.type, d.text);
                $('#file_uploaderQueue').hide();
                return false;
              }
  					}

  				  return true;
  				},
          'scriptData' 		 : {
             'AWSAccessKeyId': '#{aws_access_key}',
             'key': '#{key}',
             'acl': '#{acl}',
             'policy': '#{s3_policy}',
  					 'success_action_status': '201',
             'signature': encodeURIComponent(encodeURIComponent('#{s3_signature}')),
        		 'Content-Type': ''
            }
  			});
  		});
    ))
  end

  def bucket_url
    "http://#{bucket}.s3.amazonaws.com/"
  end

  def key
    "#{upload_path}/${filename}#{rangen}"
  end

  def rangen
    @rangen ||= '' # rand(36 ** 8).to_s(36)
  end

  def policy_doc
    @policy ||= "{'expiration': '#{expiration_date}',
        'conditions': [{'bucket': '#{bucket}'},
          ['starts-with', '$key', '#{upload_path}'],
          {'acl': '#{acl.to_s}'},
          ['content-length-range', 0, #{max_filesize}],
          {'success_action_status': '201'},
          ['starts-with','$folder',''],
          ['starts-with','$Filename',''],
          ['starts-with','$fileext',''],
        ]
      }"
  end

  def s3_policy
    Base64.encode64(policy_doc).gsub(/\n|\r/, '')
  end

  def s3_signature
    raise "Secret key should not be nil." if self.aws_secret_key.nil?
    b64_hmac_sha1(aws_secret_key, s3_policy)
  end

  def load_s3config
    a = YAML.load_file("#{Rails.root}/config/amazon_s3.yml")
    puts 'loading config from yaml file.'
    @s3config = a['development']
    puts @s3config.inspect
  end

  def s3config(name)
    load_s3config unless @s3config
    @s3config[name]
  end

  def aws_access_key
    s3config 'access_key_id'
  end

  def aws_secret_key
    s3config('secret_access_key')
  end

  def bucket
    s3config('bucket')
  end

  def acl
    s3config('default_acl') || "public-read"
  end

  def upload_path
    s3config('upload_path') || 'attachments'
  end

  def max_filesize
    s3config('max_file_size') || 1000.megabyte
  end

  def expiration_date
   10.hours.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z')
  end

  def default_options
    {
      :button_text => 'Add File',
      :button_img => '/images/uploadify/upload.png',
      :height => '20',
      :width => '30',
      :file_ext => '*.*',
      :file_input_selector => '#file_upload',
      :file_desc => 'Please choose your file'
      }
  end
end

