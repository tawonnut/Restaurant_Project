FactoryGirl.create(:user, email:"superuser@gmail.com",super_user: true,password:"test1234", password_confirmation:"test1234")
FactoryGirl.create(:user, email:"superuser2@gmail.com",super_user: true,password:"test1234", password_confirmation:"test1234",name:"บอมเบคนเดิม",surname:"เพิ่มเติมเดี๋ยวบอก")


puts "Generate User Complete"