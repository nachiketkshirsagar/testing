class UploadFile

  def initialize(options)
    @mer_utility = options[:utility_object]
    @object_config = MerchantUtility::OBJECT_CONFIG
    @config = @mer_utility.config
    @flag = 0
  end

  def click_mer_dir
    	sleep 5
    	dir_name = find(OBJECT_CONFIG['LoginPage']['mer_dir'])
    	#dir_name = driver.find_element(:xpath, ".//*[@id='toptable']/tbody/tr/td[2]/input")
    	dir_name.send_keys 'spice'
    	dir_name.send_keys :return
        puts '0'
    end

    def upload_file
        sleep 5
        puts '1'
    	ele = driver.find_elements(OBJECT_CONFIG['Upload']['upload_button'])
    	#ele[2].attribute('title')
    	ele[2].click
        puts '2'
    	file_name = 'spice-test.csv'
    	file = File.join(Dir.pwd, './configs/file_name')
        driver.find_element(OBJECT_CONFIG['Upload']['file_name']).send_keys file
  		driver.find_element(OBJECT_CONFIG['Upload']['sub_but']).click
    end
end