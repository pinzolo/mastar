# coding: utf-8
class Color < ActiveRecord::Base
  include Mastar
  mastar_value :rgb

end

class Dow < ActiveRecord::Base
  include Mastar
  scope :holiday, -> { where(:holiday => true) }

end

class Month < ActiveRecord::Base
  include Mastar
  mastar_name :short_name

end

