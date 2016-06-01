# filename: ./spec/features/user/core/researcher_reports_spec.rb

require 'uuid'
require 'fileutils'

feature 'Researcher, CSV exports', :core, :marigold do
  background do
    @download_dir = File.join(Dir.pwd, UUID.new.generate)
    FileUtils.mkdir_p @download_dir

    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['browser.download.dir'] = @download_dir
    profile['browser.download.folderList'] = 2
    profile['browser.helperApps.neverAsk.saveToDisk'] = 'text/csv'
    profile['pdfjs.disabled'] = true
    @driver = Selenium::WebDriver.for :firefox, profile: profile

    @driver.get "#{ENV['Base_URL']}/users/sign_in"
    @driver.find_element(id: 'user_email').send_keys(ENV['Researcher_Email'])
    @driver.find_element(id: 'user_password')
           .send_keys(ENV['Researcher_Password'])
    @driver.find_element(css: '.btn.btn-default').submit
  end

  after do
    @driver.quit
    FileUtils.rm_rf @download_dir
  end

  scenario 'Researcher navigates to CSV reports, downloads all reports' do
    @driver.get "#{ENV['Base_URL']}/think_feel_do_dashboard/reports"
    file_names = %w(modulepageview modulesession lessonviewing
                    lessonslideview videosession taskcompletion
                    sitesession toolaccess useragent login comment
                    goal like nudge)
    (0..13).zip(file_names) do |i, file|
      download_link = @driver.find_elements(class: 'list-group-item')[i]
      download_link.click
      file_path = "#{@download_dir}/#{file}.csv"
      File.size(file_path).should be > 0
      @driver.execute_script('window.scrollBy(0,100)')
    end

    files = Dir.glob("#{@download_dir}/**")
    files.count.should be == 14

    sorted_files = files.sort_by { |file| File.mtime(file) }
    File.size(sorted_files.last).should be > 0
  end
end
