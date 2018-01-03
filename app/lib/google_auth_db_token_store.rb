class GoogleAuthDbTokenStore < Google::Auth::TokenStore

  def load(id)
    Googleauth.find_by(key: id)&.value
  end

  def store(id, token)
    record = Googleauth.find_or_initialize_by(key: id)
    record.value = token
    record.save!
  end

  def delete(id)
    Googleauth.find_by(key: id)&.destroy!
  end

end
