class InsertAdminUserAndRoles < ActiveRecord::Migration
  def self.up
    Role.create(:name=>"Super")
    Role.create(:name=>"Admin")
    Role.create(:name=>"User")
    user = User.create(:email=>"<%= user_email %>",
                :password=>"<%= user_password %>",
                :confirmed_at=>DateTime::now,
                :role=>:super)
    Profile.create(
      :first_name => "<%= user_first_name %>",
      :last_name => "<%= user_last_name %>",
      :blog_title => "<%= user_blog_title %>",
      :alias => "<%= user_alias %>",
      :user => user
      )
  end

  def self.down
    User.find_by_email("<%= user_email %>").destroy
    Role.all.each {|t| t.destroy}
  end
end

