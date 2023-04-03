# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :name,
                        :email,
                        :password_digest
  has_secure_password

  validates :email, uniqueness: true

  has_many :viewing_party_users
  has_many :viewing_parties, through: :viewing_party_users
end
