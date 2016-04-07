Dir["./baseclasses/orders/*.rb"].each {|file| require file }

class FtpUpload < UploadFile

  # Expected:
  #   options[:utility_object] <Class Object> : HemUtility class object to get configration
  def initialize(options)
    @purpose = 'Upload a file throught the FTP client'
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