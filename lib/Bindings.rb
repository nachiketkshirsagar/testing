require 'selenium-webdriver'
require 'appium_lib'
require 'yaml'

class Bindings
  #PLATFORM = {'web' => ['firefox', 'chrome', 'safari']}

  def launch(medium)
    #@@platform = platform
    #if platform == 'web'
      case medium
        when 'firefox'
          profile = Selenium::WebDriver::Firefox::Profile.new
          profile.assume_untrusted_certificate_issuer = false
          @@driver = Selenium::WebDriver.for :firefox, :profile => profile
          @@driver.manage.window.maximize()
        when 'chrome'
          @@driver = Selenium::WebDriver.for :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate]
          @@driver.manage.window.maximize
        when 'safari'
          @@driver = Selenium::WebDriver.for :browser_name
          @@driver.manage.window.maximize()
      end
    end
=begin
  def find(value)
    @@platform == 'web'
      @@driver.find_element(value)
  end

  def get_url(url)
    @@platform == 'web'
      @@driver.manage.timeouts.page_load = 200
      @@driver.get url
  end

  def get_text(element)
    @@platform == 'web'
      element.text
  end

  def send_text(element, value)
    @@platform == 'web'
      element.send_keys value
  end

  def clear_text(element)
    @@platform == 'web'
      element.clear
  end

  def click_action(element)
    @@platform == 'web'
      element.click
  end
=end
  def close
      @@driver.quit
  end
end
