class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :body, type: String

  def date_added
  	self.created_at.localtime.strftime("%-m/%-d/%Y | %l:%M %p")
  end

  embedded_in :post
end
