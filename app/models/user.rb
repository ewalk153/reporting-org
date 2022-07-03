class User < ApplicationRecord
  belongs_to :manager, class_name: "User", optional: true
  has_many :reports, foreign_key: "manager_id", class_name: "User"

  def self.reports_of(manager_id)
    User.where(manager_id: manager_id)
  end
end
