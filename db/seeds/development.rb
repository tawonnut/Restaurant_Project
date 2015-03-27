FactoryGirl.create(:user, email:"superuser@gmail.com",super_user: true,password:"test1234", password_confirmation:"test1234")
FactoryGirl.create(:user, email:"superuser2@gmail.com",super_user: true,password:"test1234", password_confirmation:"test1234",name:"บอมเบคนเดิม",surname:"เพิ่มเติมเดี๋ยวบอก")
FactoryGirl.create(:user, email: "User2@gmail.com", password: "test1234", password_confirmation:"test1234",name:"เจม",surname:"จิรายุ",tel:"0834554671")


puts "Generate User Complete"