class NutrientData < ActiveRecord::Base
  include NutrientModel
  set_table_name 'nutrientdatatbl'
  set_primary_key 'ndb_no'

  belongs_to :food, :foreign_key => 'ndb_no'
  belongs_to :nutrient, :foreign_key => 'nutr_no'
  #  belongs_to :source_code, :foreign_key => 'src_cd'
  #  belongs_to :derivation_code, :foreign_key => 'deriv_cd'

  delegate :name, :decimals, :units, :order, :tagname, :to => :nutrient

  # Amount in 100 grams, edible portion.
  # Nutrient values have been rounded to a specified number of decimal places for each nutrient. 
  # Number of decimal places is listed in the Nutrient Definition file.
  def value_per_100g; nutr_val; end
  
  def value_per_g; value_per_100g / 100.0; end

  # Number of data points (previously called Sample_Ct) is the number of analyses used to calculate the nutrient value.
  # If the number of data points is 0, the value was calculated or imputed.
  def number_of_data_points; num_data_pts; end

  # Standard error of the mean. Null if can not be calculated.
  def standard_error; std_error; end

  # NDB number of the item used to impute a missing value. Populated only for items added or updated starting with SR14.
  def ref_id; ref_ndb_no; end

  # Indicates a vitamin or mineral added for fortification or enrichment. This field is populated for ready-to-eat
  # breakfast cereals	in food group 8.
  def added_nutrition?; add_nutr_mark == 'Y'; end

  # Number of studies.
  def number_of_studies; num_studies; end

  # Minimum value.
  # min

  # Maximum value.
  # max

  # Degrees of freedom.
  def degrees_of_freedom; df; end

  # Lower 95% error bound.
  def lower_error_bound; low_eb; end
    
  # Upper 95% error bound.
  def upper_error_bound; up_eb; end

  # Statistical comments. See definitions below.
  # Definitions of each statistical comment included in the Nutrient Data table follow:
  # 1.	The displayed summary statistics were computed from data containing some less-than
  #     values. Less-than, trace, and not-detected values were calculated.
  # 2.	The displayed degrees of freedom were computed using Satterthwaite’s approximation (Korz
  #     and Johnson, 1988).
  # 3.	The procedure used to estimate the reliability of the generic mean requires that the data
  #     associated with each study be a simple random sample from all the products associated with
  #     the given data source (for example, manufacturer, variety, cultivar, and species).
  # 4.	For this nutrient, one or more data sources had only one observation. Therefore, the standard
  #     errors, degrees of freedom, and error bounds were computed from the between-group standard
  #     deviation of the weighted groups having only one observation.
  def statistical_comments; stat_cmt; end

  # Confidence Code indicating data quality, based on evaluation of sample plan, sample handling, analytical method,
  # analytical quality control, and number of samples analyzed. Not included in this release, but is planned for
  # future releases.
  def confidence_code; cc; end



  # Nutrient value per ousehold measures for food item (for example, 1 cup, 1 tablespoon, 1 fruit, 1 leg).
  # Weights are given for edible material without refuse, that is, the weight of an apple without the core or stem, or
  # a chicken leg without the bone, and so forth.
  def values_per_portions
    Hash[(
      food.weights_by_portions.map do |weight_description, weight_of_a_portion_in_grams|
        [weight_description, value_per_100g / 100 * weight_of_a_portion_in_grams]
      end
    )]
  end


end
