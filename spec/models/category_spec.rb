require 'rails_helper'

describe Category do
	it { should have_many(:videos) }
	it { should validates_presence_of(:name) }

	describe "#recent_videos" do
		it "returns the videos in the reverse chronical order by created_at" do
			comedies = Category.create(name: "comedies")
			futurama = Video.create(title: "futurama", description: "space travel", category: comedies, created_at: 1.day.ago)
			south_park = Video.create(title: "south park", description: "crazy kids", category: comedies)
			expect(comedies.recent_videos).to eq([south_park, futurama])
		end
		it "returns all the videos if there are less than 6 videos" do
			comedies = Category.create(name: "comedies")
			futurama = Video.create(title: "futurama", description: "space travel", category: comedies, created_at: 1.day.ago)
			south_park = Video.create(title: "south park", description: "crazy kids", category: comedies)
			expect(comedies.recent_videos.count).to eq(2)
	
		end
		it "returns 6 videos if there are more than 6 videos" do
			comedies = Category.create(name: "comedies")
			7.times { Video.create(title: "foo", description: "bar", category: comedies)}
			expect(comedies.recent_videos.count).to eq(6)
		end
		it "returns the most recent 6 videos" do
			comedies = Category.create(name: "comedies")
			6.times { Video.create(title: "foo", description: "bar", category: comedies)}
			tonight = Video.create(title: "tonight show", description: "talk show", category: comedies, created_at: 1.day.ago)
			expect(comedies.recent_videos).not_to include(tonight)
		end
		it "returns an empty array if the category does not have any videos" do
			comedies = Category.create(name: "comedies")
			expect(comedies.recent_videos).to eq([])
		end
	end

end