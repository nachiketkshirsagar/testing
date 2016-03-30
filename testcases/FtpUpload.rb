Dir["./baseclasses/orders/*.rb"].each {|file| require file }

class FtpUpload < UploadFile

  # Expected:
  #   options[:utility_object] <Class Object> : HemUtility class object to get configration
  def initialize(options)
    @purpose = 'It checks login, adding BN product to cart, add and verify shipping and billing details, place order and Logout'
    @priority = 'smoke'
    @mer_utility = options
    super(options)
  end

  def get_test_variables
    opt = {'purpose' => @purpose, 'priority' => @priority}
  end

  def execute
    begin
      step1
      step2
    rescue Exception => e
      p e.message
      p e.backtrace
    end
  end

  def step1
    if @mer_utility.login
      p 'MerchantUtility::Login Pass'
    else
      p 'MerchantUtility::Login Fail'
    end
  end
end