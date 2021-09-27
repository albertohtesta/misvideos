class Video < ApplicationRecord
  belongs_to :category
  has_many :reviews, -> { order(:updated_at) }
  #validates :title, presence: true
  #validates :description, presence:true
  validates_presence_of :title, :description

  def self.search_by_title(search_term)
  	return [] if search_term.blank?
  	where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end

end
