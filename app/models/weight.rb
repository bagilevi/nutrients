class Weight < ActiveRecord::Base
  include NutrientModel
  set_table_name 'weighttbl'
  set_primary_key 'id'
  belongs_to :food, :foreign_key => 'ndb_no'

  # Sequence number.
  def sequence_number; seq; end

  # Unit modifier (for example, 1 in “1 cup”).
  # amount

  # Description (for example, cup, diced, and 1-inch pieces).
  def description; msre_desc; end

  def gram_weight; gm_wgt; end

  def number_of_data_points; num_data_pts; end

  def standard_deviation; std_dev; end

  

end
