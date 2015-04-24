class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String
  field :Clicks, type: Integer, default: 0

 scope :hottest, proc {where(:Clicks.gt => 5).desc}
 field :replies_count, type: Integer, default: 0

  has_many :replies, dependent: :destroy
  belongs_to :author, class_name: "User"
end
