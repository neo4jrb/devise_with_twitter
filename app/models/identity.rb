class Identity 
  include Neo4j::ActiveNode
  property :user, type: String
  property :provider, type: String
  property :uid, type: String

  has_one :in, :user, type: :has_identity

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
  
  def self.find_for_oauth(auth)
    where(uid: auth.uid, provider: auth.provider).first ||
      create(uid: auth.uid, provider: auth.provider)
  end
end
