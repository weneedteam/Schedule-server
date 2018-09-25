json.user do
    json.extract! @user, :id, :name, :email, :phone
    json.birth @user.birth.to_i
end