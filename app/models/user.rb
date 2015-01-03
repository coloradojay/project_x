class User
  include Mongoid::Document

  field :user_name, type: String
  field :name, type: String
  field :email, type: String
  field :image, type: String

  has_many :posts
end
