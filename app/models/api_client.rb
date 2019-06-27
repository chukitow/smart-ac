class ApiClient < ApplicationRecord
  validates :token, presence: true
end
