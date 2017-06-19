# Simulates a browser logging into infinite campus using ENV variables
# Parses out the current day color from the attendance tab and sets redis key `current_day_color`
class ResolveDayColorJob < ApplicationJob
  queue_as :default

  def perform(*args)
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
        Capybara.current_session.reset!
        $redis.del("current_day_color")
        return
      ensure
      end
    end

    browser.within_frame 'frameDetail' do
      color = browser.find("td", id: "dow").text.split("(")[1].chomp(")") # Ex: "Friday (W Day)" -> W Day
      puts "ResolveDayColorJob | Today was determined to be a " + color
      $redis.set("current_day_color", color)
    end
    Capybara.current_session.reset!
  end
end
