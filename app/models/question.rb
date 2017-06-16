# Модель вопроса.
class Question < ActiveRecord::Base
  belongs_to :user

  belongs_to :questioning_user, class_name: 'User'

  validates :text, :user, presence: true
end
