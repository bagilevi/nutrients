class Food < ActiveRecord::Base
  include NutrientModel
  set_table_name 'fooddescriptiontbl'
  set_primary_key 'ndb_no'
  belongs_to :group, :class_name => 'FoodGroup', :foreign_key => 'fdgrp_cd'
  has_many :nutrients, :class_name => 'NutrientData', :foreign_key => 'ndb_no'
  has_many :weights, :foreign_key => 'ndb_no'

  # 200-character description of food item.
  def description; long_des; end

  # 60-character abbreviated description of food item. Generated from the 200-character description using abbreviations
  # in Appendix A. If short description is longer than 60 characters, additional abbreviations are made
  def short_description; shrt_des; end

  # Other names commonly used to describe a food, including local or regional names for various foods, for example,
  # “soda” or “pop” for “carbonated beverages.”
  def common_name; comname; end

  # Indicates the company that manufactured the product, when appropriate.
  def manufacturer_name; manufacname; end

  # Indicates if the food item is used in the USDA Food and Nutrient Database for Dietary Studies (FNDDS) and thus has
  # a complete nutrient profile for the 65 FNDDS nutrients.
  def complete?; survey == 'Y'; end

  # Description of inedible parts of a food item (refuse), such as seeds or bone.
  def refuse_description; ref_desc; end

  # Percentage of refuse.
  def refuse_percentage; refuse; end

  # Scientific name of the food item. Given for the least processed form of the food (usually raw), if applicable.
  def scientific_name; sciname; end

  # Factor for converting nitrogen to protein (see p. 9).
  # n_factor

  # Factor for calculating calories from protein (see p. 11).
  # pro_factor

  # Factor for calculating calories from fat (see p. 11).
  # fat_factor

  # Factor for calculating calories from carbohydrate (see p. 11).
  # cho_factor

  def weights_by_portions
    Hash[(
      weights.map do |weight|
        [weight.description, weight.gram_weight]
      end
    )]
  end


  scope :search, lambda{ |keyword| where("long_des LIKE '#{sanitize_sql(keyword)}%'") }


end