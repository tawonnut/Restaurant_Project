FactoryGirl.create(:user, email: "User1@gmail.com", password: "test1234", password_confirmation:"test1234",name:"User1",tel:"0898766541")

FactoryGirl.create(:user, email: "User2@gmail.com", password: "test1234", password_confirmation:"test1234",name:"User2",tel:"0834554671")

FactoryGirl.create(:user, email:"super@gmail.com",super_user: true,password:"test1234", password_confirmation:"test1234")
puts "Generate User.."