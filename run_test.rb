require 'trollop'
Dir["./lib/*.rb"].each {|file| require file }
Dir["./testcases/*.rb"].each {|file| require file }
list_of_configs = Dir.entries('./configs/').reject{|entry| entry == "." || entry == ".."}

opts = Trollop::options do
  opt :test_case_name, 'Pass test case name it should not be nil', :type => :string, :required => true
  opt :config, "Provide one of these 'us6.yml','us7.yml','us8.yml','us9.yml' 'sgp.yml' or 'prod.yml'", :type => :string, :required => true
  opt :medium, "Pass 'firefox','chrome' or 'safari' when Platform = WEB and 'ios' or 'android' when Platform = MOBILE", :type => :string, :required => true
  opt :platform, "Pass one of these 'web' or 'ipad'", :type => :string, :required => true
end

Trollop::die :test_case_name, "Pass test case name it should not be nil" if opts[:test_case_name] == nil
#Trollop::die :log_file_path, "Provide full log file path" if opts[:log_file_path] == nil
Trollop::die :platform, "Pass one of these 'web' or 'mobile'" unless Bindings::PLATFORM.keys.include? opts[:platform]
Trollop::die :medium, "Pass 'firefox','chrome' or 'safari' when Platform = WEB and 'ios' or 'android' when Platform = MOBILE" unless Bindings::PLATFORM[opts[:platform]].include? opts[:medium]
Trollop::die :config, "Provide one of these 'us6.yml', 'us7.yml', 'us8.yml', 'us9.yml' 'sgp.yml' or 'prod.yml'" unless list_of_configs.include? opts[:config]

medium = opts[:medium]
platform = opts[:platform]
test_case = opts[:test_case_name]
config = opts[:config]

mer_utility_object = MerchantUtility.new(config)
mer_utility_object.launch(medium,platform)
klass = Object.const_get(test_case)
run = klass.new({:utility_object => mer_utility_object})
run.execute
mer_utility_object.close