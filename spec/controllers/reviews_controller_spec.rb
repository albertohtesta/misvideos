require "rails_helper"

describe ReviewsController do
  describe "POST create" do
    context "with authenticated users" do
      let (:current_user) {Fabricate(:user)}
      let (:video) {Fabricate(:video)}
      before { session[:user_id] = current_user.id }

      context "with valid inputs" do
        before {post :create, params: {review: Fabricate.attributes_for(:review), video_id: video.id}}

        it "redirects to video show page" do
          expect(response).to redirect_to video
        end

        it "create a review" do
          expect(Review.count).to eq(1)
        end

        it "create a review associated with video" do
          expect(Review.first.video).to eq(video)
        end

        it "create a review associated with the signed in user" do
          expect(Review.first.user).to eq(current_user)
        end

      end

      context "with invalid inputs" do
        it "does not create a review" do
          post :create, params: {review: {rating: 4}, video_id: video.id}
          expect(Review.count).to eq(0)
        end

        it "renders the videos/show template" do
          post :create, params: {review: {rating: 5}, video_id: video.id}
          expect(response).to render_template "videos/show"
        end

        it "sets @video" do
          post :create, params: {review: {rating: 5}, video_id: video.id}
          expect(assigns(:video)).to eq(video)
        end
        it "sets @reviews" do
          review = Fabricate(:review, video: video)
          post :create, params: {review: {rating: 5}, video_id: video.id}
          expect(assigns(:reviews)).to match_array([review])
        end

      end

    end 

    context "with unauthenticated users" do
      let (:video) {Fabricate(:video)}
      it "redirects to the sign in path" do
        post :create, params: {review: {rating: 5}, video_id: video.id}
        expect(response).to redirect_to sign_in_path
      end
    end
    
  end
end