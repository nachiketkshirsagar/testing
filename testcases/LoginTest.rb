Dir["./lib/*.rb"].each {|file| require file }

class LoginTest
  def initialize
    @purpose = 'It will check Login, loading of all browse pages and Logout'
    @priority = 'smoke'
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
    if MerchantUtility.login
      p 'LoginTest::Login Pass'
    else
      p 'LoginTest::Login Fail'
    end
  end

  def step2
    if MerchantUtility.logout
      p 'LoginTest::Logout Pass'
    else
      p 'LoginTest::Logout Fail'
    end
  end
end
