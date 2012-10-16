# coding: utf-8
class Color < ActiveRecord::Base
  include Mastar
  mastar.value :rgb

end

class Dow < ActiveRecord::Base
  include Mastar
  scope :holiday, -> { where(:holiday => true) }
  mastar.key :name

end

class Month < ActiveRecord::Base
  include Mastar
  mastar.name :short_name

end

