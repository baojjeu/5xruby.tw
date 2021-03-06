# == Schema Information
#
# Table name: speakers
#
#  id           :integer          not null, primary key
#  avatar       :string(255)
#  name         :string(255)      not null
#  summary      :text
#  is_online    :boolean          default(FALSE), not null
#  created_at   :datetime
#  updated_at   :datetime
#  role         :string(255)      default("consultant"), not null
#  title        :string(255)
#  facebook_url :string(255)
#  twitter_url  :string(255)
#  google_url   :string(255)
#  blog_url     :string(255)
#  sort_id      :integer          default(0), not null
#

class Speaker < ActiveRecord::Base
  # scope macros
  scope :online, -> { where(is_online: true) }

  # Concerns macros
  extend Enumerize
  include Select2Concern

  # Constants

  # Attributes related macros
  mount_uploader :avatar, SpeakerAvatarUploader

  # association macros
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :videos
  has_many :translations, as: :translatable

  # validation macros
  validates :name, :role, presence: true
  validates :name, uniqueness: true
  select2_white_list :name
  enumerize :role, in: %i[author consultant speaker parttime-speaker assistant-speaker]

  # callbacks

  protected
  # callback methods
end
