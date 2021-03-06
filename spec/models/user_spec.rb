require 'rails_helper'

describe User do
  it { should have_many(:queue_items).order(:position) }
  it { should have_many(:reviews).order("created_at DESC")}
  it { should have_many(:following_relationships)}

  it_behaves_like "tokenable" do
    let(:object) {Fabricate(:user)}
  end

  describe "#queued_video?" do
    it "return true if truehe user has queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      user.queued_video?(video).should be_truthy
    end
    it "return false if the user has not queued the video" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      user.queued_video?(video).should be_falsey
    end
  end

  describe "#follow?" do
    it "returns true if the user has a relationship with anthor user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower: alice, leader: bob)
      alice.follow?(bob).should be_truthy
    end

    it "returns false if the user does not have a relationship with anthor user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, follower: bob, leader: alice)
      alice.follow?(bob).should be_falsey
    end
  end

end