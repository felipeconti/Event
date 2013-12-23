require "spec_helper"

feature "Login" do
  scenario "with valid credentials" do

    # visit root_path

    # fill_in label("user.email"), with: user.email
    # fill_in label("user.password"), with: "test"
    # click_button t("button.login")

    # expect(current_path).to eql(root_path)
    # expect(page).to have_content(t("user.greeting", name: user.name))
  end

  scenario "with invalid credentials" do
    # visit root_path
    # click_link t("menu.login")
    # click_button t("button.login")

    # expect(current_path).to eql(login_path)
    # expect(page).to have_content(alert("login.create"))
  end

  scenario "Access root_path" do
    visit root_path

    expect(current_path).to eql(root_path)
  end
end
