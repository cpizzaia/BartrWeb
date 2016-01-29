class Item < ActiveRecord::Base
  validates :owner_id, :name, :description, :image, presence: true
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :owner_id,
    primary_key: :id
  )
end
