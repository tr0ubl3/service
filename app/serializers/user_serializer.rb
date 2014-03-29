class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :this_user

  def this_user
  	current_user.id
  end
end
