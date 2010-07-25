class Nutrient < ActiveRecord::Base
  include NutrientModel
  set_table_name 'nutrientdefinitiontbl'
  set_primary_key 'nutr_no'

  # Name of nutrient/food component.
  def name; nutrdesc; end

  # Number of decimal places to which a nutrient value is rounded.
  def decimals; num_dec; end

  # Units of measure (mg, g, μg, and so on).
  # units

  # Used to sort nutrient records in the same order as various reports produced from SR.
  def order; sr_order; end


  # International Network of Food Data Systems (INFOODS) Tagnames.† A unique abbreviation for a nutrient/food component developed by INFOODS to aid in the interchange of data.
  # tagname

end