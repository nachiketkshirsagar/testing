############################################
# Author: Nachiket Kshirsagar
# Date:10/11/15
# This file is to run test in form of a suite
############################################

require 'trollop'
require 'fileutils'
require 'logger'
#require 'result_generation'
#require 'email_sender'

Dir["./lib/*.rb"].each {|file| require file }
Dir["./testcases/*.rb"].each {|file| require file }
list_of_configs = Dir.entries('./configs/').reject{|entry| entry == "." || entry == ".."}

opts = Trollop::options do
  opt :suite, 'Pass test case name it should not be nil :: For E.g.,ruby run_suite.rb -s ex.yaml -m firefox -c us6.yml -p web -r smoke', :type => :string, :required => false
  opt :config, "Provide one of these 'us6.yml','us7.yml','us8.yml','us9.yml' 'sgp.yml' or 'prod.yml'", :type => :string, :required => true
  opt :medium, "Pass 'firefox','chrome' or 'safari' when Platform = WEB and 'ios' or 'android' when Platform = MOBILE", :type => :string, :required => true
  opt :platform, "Pass one of these 'web' or 'ipad'", :type => :string, :required => true
  opt :priority, 'Pass priority as smoke or regression', :type => :string, :required => true
  opt :project, 'Project name if you want to run a suite for the whole project :: For E.g., ruby run_suite.rb -o project.yaml -m firefox -c sgp.yml -p web -r regression' , :type => :string, :required => false
end

Trollop::die :suite, "Pass test case name it should not be nil" if opts[:suite] && opts[:project]!= nil
Trollop::die :project, 'Pass project name' if opts[:suite] && opts[:project] != nil
Trollop::die :platform, "Pass one of these 'web' or 'mobile'" unless Bindings::PLATFORM.keys.include? opts[:platform]
Trollop::die :medium, "Pass 'firefox','chrome' or 'safari' when Platform = WEB and 'ios' or 'android' when Platform = MOBILE" unless Bindings::PLATFORM[opts[:platform]].include? opts[:medium]
Trollop::die :config, "Provide one of these 'us6.yml', 'us7.yml', 'us8.yml', 'us9.yml' 'sgp.yml' or 'prod.yml'" unless list_of_configs.include? opts[:config]
Trollop::die :priority, 'Provide priority as smoke or regression' if opts[:priority] == nil

medium = opts[:medium]
platform = opts[:platform]
suite_name = opts[:suite]
config = opts[:config]
priority = opts[:priority]
project = opts[:project]
start_time = Time.now

#result_data = Log.new
#current_test_id = 0
#exit_status = true
mer_utility_object = MerchantUtility.new(config)
mer_utility_object.launch(medium, platform)
testcase_pass = []
testcase_fail = []
@row = Hash.new

if (opts[:suite] != nil) then
  test_suite = YAML.load_file './configs/' + opts[:suite]
  test_suite[opts[:priority]].each do |k|
    STDERR.puts "Running #{k}"
    klass = Object.const_get(k)
    run = klass.new({:utility_object => mer_utility_object})
    run.execute
    # puts "result_data.step_fail_count:: #{result_data.step_fail_count.to_i}"
    purpose = run.get_test_variables
    desc = purpose.values
    #criteria = Log.testcase_result
    @row[:"#{k}"] = desc[0],"#{medium}", criteria
    if criteria == 'pass'
      testcase_pass << 1
    else
      testcase_fail << 1
    end
  end

else
  project_name = YAML.load_file './configs/' + opts[:project]
  project_name.each do |k,v|
    v.each do |k,v|
      v .each do |i|
        run_file = YAML.load_file './configs/' + i
        run_file[opts[:priority]].each do |k|
          STDERR.puts "Running #{k}"
          klass = Object.const_get(k)
          run = klass.new({:utility_object => mer_utility_object})
          run.execute
          purpose = run.get_test_variables
          desc = purpose.values
          #criteria = Log.testcase_result
          #@row[:"#{k}"] = desc[0],"#{medium}", criteria
          #if criteria == 'pass'
            #testcase_pass << 1
          #else
            #testcase_fail << 1
          #end
        end
      end
    end
  end
end
=begin
@overall = testcase_pass.size + testcase_fail.size
Results.create_report
Results.insert_head_title(' -- Report --')
Results.insert_reportname_date('Test Results for Suite/Project',$result_date )
end_time = Time.now
t = end_time - start_time
mm, ss = t.divmod(60)
hh, mm = mm.divmod(60)
total_time_taken = "%d hours, %d minutes and %d seconds" % [hh, mm, ss]
Results.summary_report(@overall ,testcase_pass.size,testcase_fail.size,total_time_taken)
Results.start_table
@row.each do |k,v|
  Results.report_row(k,v[0],v[1], v[2])
end
Results.close_table
EmailSender.email_sender(Results.get_html_text)
=end
mer_utility_object.close
# For E.g.,ruby run_suite.rb -s ex.yaml -m firefox -c sgp.yml -p web -r regression
# Project = ruby run_suite.rb -o project.yaml -m firefox -c sgp.yml -p web -r regression