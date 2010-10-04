class AccessControlEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  belongs_to :resource, :polymorphic=>true
  validates :resource_type, :presence=>true

  default_scope order(:position)

  scope :by_resource, lambda {|resource_type, resource_id|
    where(:resource_type=>resource_type).
    where(:resource_id=>resource_id)
  }
  scope :by_role, lambda {|role_id|
    where(:role_id=>role_id)
  }
  scope :by_class, lambda {|class_name|
    where(:resource_type=>class_name)
  }

  def resource=(res)
    @res = res
    if res.is_a? Class then self.resource_type = res.name
    else
      self.resource_id = res.id
      self.resource_type = res.class.name
    end
  end

  def resource
    unless @res
      if resource_id
        @res = resource_type.constantize.find(resource_id) unless resource_type.empty?
      else
        @res = resource_type.constantize unless resource_type.empty?
      end
    end
    @res
  end

  def resource_class; resource_type.constantize unless resource_type.empty?; end;

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
    able = self.can ? :can : :cannot
    ability.send able, verb.to_sym, resource_type.try(:constantize), able_options
  end

  def able_options
    if resource.is_a?(ActiveRecord::Base)
      options.merge({:id=>resource.id})
    else
      options
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
    if role.kind_of? Role
      self.role_id = role.id
    else
      role = role.to_s.camelize
      self.role_id = (role.is_numeric? ? role : Role.find_by_name(role).id) unless role.empty?
    end
  end

  attr_protected :serialized_options

end

