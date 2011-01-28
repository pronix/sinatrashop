require 'lib/model/state'

class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :abbr, :null => false
      t.string :name, :null => false
    end

    State.create({ :abbr => "IA", :name => "Iowa" })
    State.create({ :abbr => "UT", :name => "UT" })
  end

  def self.down
    drop_table :states
  end
end
