class ActiveRecordTokenStore < Google::Auth::TokenStore
  def load(id)
    @store.transaction { @store[id] }
  end

  def store(id, token)
    @store.transaction { @store[id] = token }
  end

  def delete(id)
    @store.transaction { @store.delete(id) }
  end
end
