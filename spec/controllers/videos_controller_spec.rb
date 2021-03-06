require 'rails_helper'

describe VideosController do

  describe "GET show" do
    it "sets @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, params: { id: video.id }
      expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, params: { id: video.id }
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "redirect the user to sign in path for unauthenticated users" do
      video = Fabricate(:video)
      get :show, params: { id: video.id }
      expect(response).to redirect_to sign_in_path
    end

  end

=begin
  describe "Post search" do
    it "sets @results variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: "Futurama")
      post :search, params: { search_term: 'rama'}
      expect(assigns(:results)).to eq([futurama])
    end

    it "redirect the user to sign in path for unauthenticated users" do
      futurama = Fabricate(:video, title: "Futurama")
      post :search, params: { search_term: 'rama' }
      expect(response).to redirect_to sign_in_path
    end

  end
=end
end
