class User < ApplicationRecord
  
  # acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher

  
  has_many :participations
  has_many :activities, :through => :participations
  has_many :assignments  
  has_many :user_roles
  has_many :roles, through: :user_roles

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  
  # def generate_new_authentication_token
  #   token = User.generate_unique_secure_token 
  #   update_attribute :authentication_token, token
  # end

  def role?(role)  
    roles.any? { |r| r.name.underscore.to_sym == role }  
  end 

  #after_create :assign_default_role

  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:privilegeuser)
      self.add_role(:normaluser)
    else
      self.add_role(:normaluser) if self.role.blank?
      self.add_role(:pricilegeuser) 
    end
  end

end
