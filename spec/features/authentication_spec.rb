require 'spec_helper'
require 'rails_helper'
describe "Authentication, Register", js: true do
 
 before do
    @new_path   = new_user_session_path
  end

    it "Register and log-in" do
        visit @new_path
        click_on "สมัครสมาชิก"
        fill_in 'user[name]', with: 'testname'
        fill_in 'user[surname]', with: 'testsurname'
        fill_in 'user[tel]', with: '089999999'
        fill_in 'user[email]', with: 'test@gmail.com'
        fill_in 'user[password]', with: 'test1234'
        fill_in 'user[password_confirmation]', with: 'test1234'
        click_on 'ยืนยัน'
        expect(page).to have_content 'ร้านของคุณ'
        all('.dropdown-toggle')[1].click
        click_on 'ออกจากระบบ'

        visit @new_path
        click_on "ลืมรหัสผ่านเดิม?"
        fill_in 'user[email]', with: 'test@gmail.com'
        click_on "ยืนยัน"
        expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
        expect(ActionMailer::Base.deliveries).not_to be_empty
        fill_in 'user[email]', with: 'test@gmail.com'
        fill_in 'user[password]', with: 'test1234'
        click_on "ยืนยัน"
        page.should have_content'เข้าสู่ระบบเรียบร้อยแล้ว'    
    end

end
