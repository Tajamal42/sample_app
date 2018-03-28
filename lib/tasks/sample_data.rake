namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(name: "Tajamal Hussain",
							 email: "tajamal.azan@gmail.com",
							 password: "123@45",
							 password_confirmation: "123@45")
							 admin.toggle!(:admin)
	end
end