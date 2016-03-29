require 'yaml'

class MerchantUtility < Bindings
  attr_accessor :config

  OBJECT_CONFIG = YAML.load_file "./object_repository/object_config.yml"

  def initialize(config_file)
    @config = YAML.load_file "./configs/#{config_file}"
  end

  def login
    creds = ['54.179.164.143', 'spice-test', 'spicetest123']
      var = ".//*[@id='LoginForm1']/fieldset/div"
        i = 1 
        j = 0
      while i < 4 do 
        ele = driver.find_element(:xpath, var+"[#{i}]/input")
        ele.send_keys  "#{creds[j]}"
        i += 1
        j += 1
      end
        find(OBJECT_CONFIG['LoginPage']['button_login']).click
  end

  def logout
    find(@config['logout']).click
    sleep 2
  end


end
