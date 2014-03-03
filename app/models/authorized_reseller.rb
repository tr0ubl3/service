class AuthorizedReseller < Firm
  has_many :machines
  has_many :users
end
