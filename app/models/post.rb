class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid

  field :title, type: String
  field :dog_breed, type: String
  field :body, type: String
  field :url, type: String
  field :coordinates, :type => Array
  field :address, :type => String


  mount_uploader :image, AvatarUploader

  def date_added
  	self.created_at.localtime.strftime("%-m/%-d/%Y | %l:%M %p")
  end

  # Geocoder validation
  geocoded_by :address               # can also be an IP address
  # after_validation :geocode          # auto-fetch coordinates
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  #validating post body is present
  validates :title, presence: true
  validates :body, presence: true
  validates :address, presence: true

  belongs_to :user
  embeds_many :comments
end
