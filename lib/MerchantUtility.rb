require 'yaml'

class MerchantUtility < Bindings
  attr_accessor :config

  OBJECT_CONFIG = YAML.load_file "./object_repository/object_config.yml"

  def initialize(config_file)
    @config = YAML.load_file "./configs/#{config_file}"
  end

  def login
    get_url @config['set_url']
    get_url @config['signup_page']
    signin = find(OBJECT_CONFIG['SignUpPage']['signin_link'])
    click_action(signin)
    email = find(OBJECT_CONFIG['LoginPage']['login_email'])
    # email.send_keys @config['email']
    send_text(email, @config['email'])
    password = find(OBJECT_CONFIG['LoginPage']['login_password'])
    # password.send_keys @config['password']
    send_text(password, @config['password'])
    login_button = find(OBJECT_CONFIG['LoginPage']['signin_button'])
    # login_button.click
    click_action(login_button)
    sleep 20
    true
  end


  def browse_page
    recent_p = find(OBJECT_CONFIG['SiteHeader']['recent_purchases'])
    click_action(recent_p)
    true
  end

  def logout
    account_slide = find(OBJECT_CONFIG['HomePage']['slidemenu'])
    click_action(account_slide)
    sleep 2
    signout = find(OBJECT_CONFIG['HomePage']['signout_button'])
    click_action(signout)
    true
  end

  def get_product_page(type)
    product_type = type
    if @config['product_details'][product_type]['region'] == 'EU'
      get_url "#{@config['set_url']}/en-gb/#{@config['product_details'][product_type]['product_type']}/#{@config['product_details'][product_type]['product_id']}"
    elsif @config['product_details'][product_type]['region'] == 'US'
      get_url "#{@config['set_url']}/en/#{@config['product_details'][product_type]['product_type']}/#{@config['product_details'][product_type]['product_id']}"
    end
    sleep 30
    true
  end
end
