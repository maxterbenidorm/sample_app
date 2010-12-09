require 'spec_helper'

describe "FriendlyForwardings" do
  
  it "should forward to the requested page after sign in" do
    user = Factory(:user)
    visit edit_user_path(user)
    # Automáticamente redirige a la página de Sign in
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
    # Redirigir a la página de edit
    response.should render_template('users/edit')
  end
end
