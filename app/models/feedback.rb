class Feedback < ActiveRecord::Base
  validates :email, :presence=>true, :email=>true
  validates :name, :presence=>true, :length=>{:minimum=>6}
  validates :subject, :presence=>true

  def self.jq_validation
    JQueryValidator.new
  end
end

