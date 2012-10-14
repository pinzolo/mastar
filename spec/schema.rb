# coding: utf-8
ActiveRecord::Schema.define :version => 0 do
  create_table :colors, :force => true do |t|
    t.string :name
    t.string :rgb
  end

  create_table :dows, :force => true do |t|
    t.string :name
    t.string :short_name
    t.boolean :holiday
  end

  create_table :months, :force => true do |t|
    t.integer :month_number
    t.string :name
    t.string :short_name
  end
end
