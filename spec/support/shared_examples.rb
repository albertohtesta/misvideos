shared_examples "require_sign_in" do
  
  it "redirects to the sign in page" do
    clear_current_user
    action  # el action se manda como parametro en el spec que la necesita
    expect(response).to redirect_to sign_in_path
  end

end

shared_examples "require_admin" do
  it "redirects to the home page" do
    set_current_user
    action
    expect(response).to redirect_to home_path
  end
end

shared_examples "tokenable" do
  it "generates a random token when the user is created" do
    expect(object.token).to be_present
  end
end