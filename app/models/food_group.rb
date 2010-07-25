class FoodGroup < ActiveRecord::Base
  include NutrientModel
  set_table_name "foodgroupdescriptiontbl"
  set_primary_key "fdgrp_cd"
  has_many :foods, :foreign_key => 'fdgrp_cd'

  def name; fdgrp_desc; end
end