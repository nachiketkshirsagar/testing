Dir["./lib/*.rb"].each {|file| require file }

class LoginTest 
  def initialize(options)
    @purpose = 'login'
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

  def step2
    if @mer_utility.logout
      p 'MerchantUtility::Logout Pass'
    else
      p 'MerchantUtility::Logout Fail'
    end
  end
end