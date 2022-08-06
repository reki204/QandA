class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  mount_uploader :image, ImageUploader

  with_options presence: true do
    validates :title
    validates :body
  end

  def cannot_edit_current_user
    if @question.user != current_user
      redirect_to questions_path, alert: '不正なアクセスです。'
    end
  end
end
