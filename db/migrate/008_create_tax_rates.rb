class CreateTaxRates < ActiveRecord::Migration
  def self.up
    create_table :tax_rates do |t|
      t.references :state, :null => false
      t.decimal :rate, :null => false
    end
  end

  def self.down
    drop_table :tax_rates
  end
end
