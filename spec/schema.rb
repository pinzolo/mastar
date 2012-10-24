# coding: utf-8
ActiveRecord::Schema.define :version => 0 do
  (1..4).to_a.each do |i|
    create_table "dow#{i}s", :force => true do |t|
      t.string :name
      t.string :short_name
      t.boolean :holiday
    end
  end
end
