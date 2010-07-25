module NutrientModel

  def self.included(base)

    base.class_eval do
      begin

        # Tries to connect using the nutrientdb section in app's database.yml
        establish_connection('nutrientdb')

      rescue ActiveRecord::AdapterNotSpecified

        # Fallback to default db, defined in #{plugin}/config/database.yml
        yaml_file_in_plugin = File.join(File.dirname(File.dirname(__FILE__)), 'config', 'database.yml')
        establish_connection( YAML::load_file(yaml_file_in_plugin)['nutrientdb'] )

      end
    end

  end
  
end
