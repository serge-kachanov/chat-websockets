class Message < ActiveRecord::Base

  validates :user, presence: true

end
