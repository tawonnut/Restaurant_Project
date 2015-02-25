require 'spec_helper'

describe "Authentication, Register", js: true do
 
 before do
    @new_path   = new_user_session_path
  end

    it "Register and log-in" do
        visit @new_path
        click_on "สมัครสมาชิก"
        fill_in 'user[name]', with: 'apirak'
        fill_in 'user[surname]', with: 'wongworada'
        fill_in 'user[tel]', with: '0820800017'
        fill_in 'user[email]', with: 'apirak.5@gmail.com'
        fill_in 'user[password]', with: '123456789'
        fill_in 'user[password_confirmation]', with: '123456789'
        click_on 'Submit'

        expect(page).to have_content 'Layout Table'
        click_on 'Logout'

        click_on "Forgot your password"
        fill_in 'user[email]', with: 'tawonnut35@gmail.com'
        click_on "Submit"

        expect(page).to have_content 'Forgot your password'
        expect(ActionMailer::Base.deliveries).not_to be_empty

        
    end

end
