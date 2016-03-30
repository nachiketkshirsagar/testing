require 'selenium-webdriver'
require 'appium_lib'
require 'yaml'

class Bindings
  PLATFORM = {'web' => ['firefox', 'chrome', 'safari'], 'mobile' => ['ios', 'android']}

  def launch(medium, platform)
    @@platform = platform
    if platform == 'web'
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
    else
      case medium
        when 'ios'
          app_handle = Dir.open('./external_libs/appium/SafariLauncher.app')
          @@app_driver = Appium::Driver.new("#{}")
          @@app_driver.start_driver
          @@appium_driver = @app_driver.driver
        when 'android'
          caps = YAML.load_file './configs/'
          puts 'Android setup is not yet done'
      end
    end
  end

def get_url(url)
      @@driver.manage.timeouts.page_load = 200
      @@driver.get url
  end

  def find(value)
    if @@platform == 'web'
      @@driver.find_element(value)
    elsif instance == 'appium'
      @@appium_driver.find_element(value)
    end
  end

=begin
  def get_text(element)
    if @@platform == 'web'
      element.text
    elsif @@platform == 'appium'
      element.text
    end
  end

  def send_text(element, value)
    if @@platform == 'web'
      element.send_keys value
    elsif @@platform == 'appium'
      element.send_keys value
    end
  end

  def clear_text(element)
    if @@platform == 'web'
      element.clear
    elsif @@platform == 'appium'
      element.clear
    end
  end

  def click_action(element)
    if @@platform == 'web'
      element.click
    elsif @@platform == 'appium'
      element.click
    end
  end
=end
  def close
    if @@platform == 'web'
      @@driver.quit
    elsif @@platform == 'appium'
      @@appium_driver.driver_quit
    end
  end
end
