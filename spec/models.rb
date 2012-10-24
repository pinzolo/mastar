# coding: utf-8
class Dow1 < ActiveRecord::Base
  include Mastar
  scope :holiday, lambda { where(:holiday => true) }
  mastar.key :name

end

class Dow2 < ActiveRecord::Base
  include Mastar
  mastar.value :short_name

end

class Dow3 < ActiveRecord::Base
  include Mastar
  mastar.name :short_name

end

class Dow4 < ActiveRecord::Base
  include Mastar
  mastar :name => :short_name, :value => :name, :key => :name
end
