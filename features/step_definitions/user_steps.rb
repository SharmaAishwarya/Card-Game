
Given /^the following users exist:$/ do |user_table|
  user_table.hashes.each {|usr| User.create!(usr)}

end

###LOGIN
Given /^I'm on the login page$/ do
  visit login_path
end

Then /^I should see a username field and password field$/ do
  expect(page).to have_field('loginUser')
  expect(page).to have_field('loginEmail')

end

When /^I enter username as "(.*?)"$/ do |username|

  fill_in 'loginUser', with: username

end

And /^password as "(.*?)"$/ do |password|

  fill_in 'loginEmail', with: password

end

And /^I press submit$/ do
  click_button 'login_submit'
end


###Signup

Given /^I'm on the sign-up page$/ do
  visit new_user_path
end

When /^I enter username,email,password and press submit: "(.*?)"$/ do |arg1|
  args = arg1.split(',')
  fill_in "username", :with => arg1[0]
  fill_in "email", :with => arg1[1]
  fill_in "password", :with => arg1[2]
  click_button("UserCreate")
end

Then /^I should see: "(.*?)"$/ do |arg1|
  page.should have_selector ".alert", text: arg1
end