# Simulates a browser logging into infinite campus using ENV variables
# Parses out the current day color from the attendance tab and sets redis key `current_day_color`
class ResolveDayColorJob < ApplicationJob
  queue_as :default

  # Fails assuming there is no school today
  def failure_with_assumption
    puts "ResolveDayColorJob | Unable to find element for current date on infinite campus. School is likely not in session today."
    Capybara.current_session.reset!
    $redis.del("current_day_color")
    notify_integrations "Day color updated to *\"No School Today 👍 \"* from Infinite Campus."
  end

  def perform(*args)
    browser = Capybara.current_session
    browser.visit "https://ic.syosset.k12.ny.us/"
    browser.find("#username").set(ENV['IC_USERNAME'])
    browser.find("#password").set(ENV['IC_PASSWORD'])
    browser.click_button("signinbtn")

    browser.within_frame 'frameDetail' do
      begin
       browser.click_link("attendance")
     rescue Capybara::ElementNotFound
       failure_with_assumption
       return
     end
    end

    browser.within_frame 'frameDetail' do
      begin
        browser.find(:xpath, "//span[contains(text(),\'#{Date.today.strftime("%B")}\')]/../../..").first("td", text: "#{Date.today.day}").click()
      rescue NoMethodError
        failure_with_assumption
        return
      ensure
      end
    end

    browser.within_frame 'frameDetail' do
      begin
        color = browser.find("td", id: "dow").text.split("(")[1].chomp(")") # Ex: "Friday (W Day)" -> W Day

        if color == "R Day"
          color = "Red Day"
        else
          color = "White Day"
        end

        puts "ResolveDayColorJob | Today was determined to be a " + color
        $redis.set("current_day_color", color)
        notify_integrations "Day color updated to *#{color}* from Infinite Campus."
      rescue NoMethodError, Capybara::ElementNotFound
        failure_with_assumption
        return
      ensure
      end
    end

    Capybara.current_session.reset!
  end
end
