class User < ApplicationRecord
  belongs_to :manager, class_name: "User", optional: true, counter_cache: :users_count
  has_many :reports, foreign_key: "manager_id", inverse_of: :manager, class_name: "User"

  def self.reports_of(manager_id)
    User.where(manager_id: manager_id)
  end
end
