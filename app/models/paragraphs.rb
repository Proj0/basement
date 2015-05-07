class Paragraphs
  include Mongoid::Document
  include Mongoid::Timestamps
  field :body, type: String, default: ""

  belongs_to :post
end
