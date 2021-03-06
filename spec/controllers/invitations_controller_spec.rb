require 'rails_helper'

describe InvitationsController do
  describe "GET new" do
    it "sets @invitation to a new invitation" do
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_new_record
      expect(assigns(:invitation)).to be_instance_of Invitation
    end
    it_behaves_like "require_sign_in" do
      let(:action){get :new}
    end
  end

  describe "POST create" do
    it_behaves_like "require_sign_in" do
      let(:action) {post :create}
    end

    context "with valid inputs" do
      it "redirects to the invitation new page" do
        set_current_user
        post :create, params: { invitation: {name: "joe", email: "joe@example.com", message: "Hey join Myflix"} }
        expect(response).to redirect_to new_invitation_path
      end

      it "creates a invitation" do
        set_current_user
        post :create, params: { invitation: {name: "joe", email: "joe@example.com", message: "Hey join Myflix"} }
        expect(Invitation.count).to eq(1)
      end
      it "sends email to the recipient" do
        set_current_user
        post :create, params: { invitation: {name: "joe", email: "joe@example.com", message: "Hey join Myflix"} }
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(["joe@example.com"])

      end
      it "sets flash success message" do
        set_current_user
        post :create, params: { invitation: {name: "joe", email: "joe@example.com", message: "Hey join Myflix"} }
        expect(flash[:success]).to be_present
      end

    end

    context "with invalid inputs" do
      after {ActionMailer::Base.deliveries.clear}
      it "renders the new template" do
        set_current_user
        post :create, params: { invitation: {email: "joe@example.com", message: "Hey join Myflix"} }
        expect(response).to render_template :new
      end
      it "does not create invitation" do
        set_current_user
        post :create, params: { invitation: {email: "joe@example.com", message: "Hey join Myflix"} }
        expect(Invitation.count).to eq(0)
      end
      it "does not send out an email" do
        set_current_user
        post :create, params: { invitation: {email: "joe@example.com", message: "Hey join Myflix"} }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
      it "sets flash error message" do
        set_current_user
        post :create, params: { invitation: {email: "joe@example.com", message: "Hey join Myflix"} }
        expect(flash[:error]).to be_present
      end
      it "set @invitation" do
        set_current_user
        post :create, params: { invitation: {email: "joe@example.com", message: "Hey join Myflix"} }
        expect(assigns(:invitation)).to be_present
      end
    end

  end
end