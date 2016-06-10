namespace :chimes do

  desc "This data migration corresponds to 20160610035258_create_managers.rb"
  task migrate_users_to_managers: :environment do
    Conference.transaction do
      Conference.find_each do |c|
        Manager.create!(conference: c, user: c.user, admin: true)
      end
    end
  end

end
