class User < ApplicationRecord
  has_secure_password

  has_many :documents

  validates :name, presence: true, uniqueness: true
  after_destroy :ensure_an_admin_remains

  private

  def ensure_an_admin_remains
    raise Error, "Can't delete last user" if User.count.zero?
  end
end
