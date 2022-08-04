class Users
  ALL_USERS = []
  attr_accessor :id, :name, :email, :password

  def initialize(name, email, password)
    @id = set_incremental_id
    @name = name
    @email = email
    @password = password
    ALL_USERS << self
  end

  def set_incremental_id
    (ALL_USERS.last&.id || 0) + 1
  end
  
  class << self
    def create(name, email, password)
      new(name, email, password)
    end

    def find_by(email)
      all.select { |user| user.email == email }.first
    end

    def authenticate(email, password)
      all.select { |user| user.email == email && user.password == password }.first
    end

    def all
      ALL_USERS
    end
  end
end
