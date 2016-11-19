class Tagging < ActiveRecord::Base
  attr_accessible :gist_id, :tag_id

  belongs_to :tag
  belongs_to :gist
end
