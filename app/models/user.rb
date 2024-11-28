class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: [:auth0]

  #associations
  has_one :profile, dependent: :destroy

  has_many :posts, dependent: :destroy
  #has_many :guides, dependent: :destroy
  #has_many :snippets, dependent: :destroy

  has_many :comments, dependent: :destroy

  #friend =>
  # Users that this user has added as friends
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend

  # Users who have added this user as a friend
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user


  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first_or_initialize
    user.update(
      provider: auth.provider,
      uid: auth.uid,
      name: auth.info.name,
      image: auth.info.image,
      token: auth.credentials.token
    )
    user
  end

end
