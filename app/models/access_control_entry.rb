class AccessControlEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  scope :by_resource, lambda {|resource_class_name, resource_id|
    where(:resource_class_name=>resource_class_name).
    where(:resource_id=>resource_id)
  }
  scope :by_role, lambda {|role_id|
    where(:role_id=>role_id)
  }
  scope :by_class, lambda {|class_name|
    where(:resource_class_name=>class_name)
  }

  def resource
    @resource ||= self.resource_class_name.constantize
  end

  def resource=(res)
    @resource = res
    if res.type==Class
      self.resource_class_name = res.name
    else
      self.options[:id] = res.id
      self.resource_class_name = res.class.name
    end
  end

  def options
    @options ||= (self.serialized_options ? eval(self.serialized_options) : {})
  end

  def options_str
    options.map{|u,v| "#{u.inspect}=>#{v.is_numeric? ? v : v.inspect}"}.join(", ")
  end
  def options_str=(str)
    opts = str.split(",").map(&:strip).map_hash{|keyval|
      key, val = keyval.split("=>").map(&:strip)
      val = val.to_i if val.is_numeric?
      if key.index(":")
        key = key.gsub(/\:/, "").to_sym
      end
      {key=>val}
    }

    @options = opts
    self.serialized_options = opts.inspect
  end

  def configure(ability)
    raise "I only like Ability" unless ability.class==Ability
    if self.can ?
      puts "can #{verb.to_sym.inspect}, #{resource.inspect}, #{options.inspect}"
      ability.can verb.to_sym, resource, options
    else
      puts "cannot #{verb.to_sym.inspect}, #{resource.inspect}, #{options.inspect}"
      ability.cannot verb.to_sym, resource, options
    end
  end

  def self.can(verb, resource, options={})
    AccessControlEntry.new(:can=>true, :verb=> verb, :resource=>resource, :options=>options )
  end
  def self.cannot(verb, resource, options)
    AccessControlEntry.new(:can=>false, :verb=> verb, :resource=>resource, :options=>options )
  end

  def method_name
    self.can ? :can : :cannot
  end

  def user_email
    self.user.email if self.user
  end
  def user_email=(email)
    self.user = User.find_by_email(email) unless email.blank?
  end

  def role=(role)
    unless role.empty?
      if role.kind_of? Role
        self.role_id = role.id
      else
        role = role.to_s.camelize
        if role.is_numeric?
          self.role_id= role
        else
          self.role_id= Role.find_by_name(role).id
        end
      end
    end
  end

  attr_protected :serialized_options

end

