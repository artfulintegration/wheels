class Discussion < ActiveRecord::Base
  belongs_to :forum
  has_many :forum_messages

  attr_accessor :new_message
  after_save :save_new_message

  def save_new_message
    self.new_message.save if self.new_message
  end

  def new_message_attributes=(attributes)
    unless attributes["body"].blank?
      self.new_message ||= ForumMessage.new(:discussion=>self)
      self.new_message.attributes = attributes
    end
  end
end

