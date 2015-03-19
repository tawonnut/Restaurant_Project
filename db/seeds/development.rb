FactoryGirl.create(:user, email:"superuser@gmail.com",super_user: true,password:"test1234", password_confirmation:"test1234")
FactoryGirl.create(:user, email: "User2@gmail.com", password: "test1234", password_confirmation:"test1234",name:"น้องแจ๊คซ่า",surname:"ห้าห้าบวก",tel:"0834554671")


puts "Generate User Complete"