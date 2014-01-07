require "spec_helper"

feature "Login" do

  scenario "Access root_path" do
    visit root_path

    expect(current_path).to eql(root_path)
  end

  scenario "with valid credentials" do

    @eu = User.create!({name: "felipe", email: "felipe@felipe.com", password: "1234567890", password_confirmation: "1234567890"})

    visit root_path

    fill_in I18n.t("email"), with: @eu.email
    fill_in I18n.t("password"), with: @eu.password

    click_button "Sign in"

    expect(current_path).to eql(root_path)
    expect(page).to have_content(I18n.t("devise.sessions.signed_in"))
  end

  scenario "with invalid credentials" do
    visit root_path

    click_button "Sign in"

    expect(current_path).to eql(new_user_session_path)
    expect(page).to have_content(I18n.t("devise.failure.invalid"))
  end

end
