class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  mount_uploader :image, ImageUploader

  with_options presence: true do
    validates :title
    validates :body
  end
end
