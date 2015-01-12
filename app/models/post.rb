class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :dog_breed, type: String
  field :body, type: String
  field :url, type: String

  mount_uploader :image, AvatarUploader

  def date_added
  	self.created_at.localtime.strftime("%-m/%-d/%Y | %l:%M %p")
  end

  #validating post body is present
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  embeds_many :comments
end
