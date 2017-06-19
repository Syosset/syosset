class ResolveDayColorJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Capybara.javascript_driver = :selenium
    Capybara.current_driver = Capybara.javascript_driver
    browser = Capybara.current_session
    browser.visit "https://ic.syosset.k12.ny.us/"
    browser.find("#username").set(ENV['IC_USERNAME'])
    browser.find("#password").set(ENV['IC_PASSWORD'])
    browser.click_button("signinbtn")

    browser.within_frame 'frameDetail' do
       browser.click_link("attendance")
    end
    browser.within_frame 'frameDetail' do
      begin
        browser.find(:xpath, "//span[contains(text(),\'#{Date.today.strftime("%B")}\')]/../../..").first("a", text: "#{Date.today.day}").click()
      rescue NoMethodError
        puts "ResolveDayColorJob | Unable to find element for current date on infinite campus. School is likely not in session today."
        browser.driver.quit()
        return
        # TODO: Set redis current-day to none
      ensure
      end
    end

    browser.within_frame 'frameDetail' do
      puts "ResolveDayColorJob | Today was determined to be a " + browser.find("td", id: "dow").text.split("(")[1].chomp(")")
      # TODO: Set redis current-day to the found type
    end
  end
end
