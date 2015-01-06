class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :pet_type, type: String
  field :body, type: String
  field :url, type: String

  def date_added
  	self.created_at.localtime.strftime("%-m/%-d/%Y | %l:%M %p")
  end

  belongs_to :user
  embeds_many :comments
end
