class Gist < ActiveRecord::Base
  attr_accessible :description, :user_id, :files_attributes, :tag_ids,
    :tags_attributes

  belongs_to :user

  has_many :files, :class_name => "GistFile", :inverse_of => :gist,
    :dependent => :destroy
  has_many :favorites
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  validates :user_id, :presence => true

  accepts_nested_attributes_for :files,
    :reject_if => lambda { |attributes| attributes[:body].blank? }
  accepts_nested_attributes_for :tags,
    :reject_if => lambda { |attributes| attributes[:id].blank? }

  def self.show_by_user(user)
    Gist.where(:user_id => user)
  end
end
