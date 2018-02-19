# Simulates a browser logging into infinite campus using ENV variables
# Parses out the current day color from the attendance tab and sets redis key `current_day_color`
class ResolveDayColorJob < ApplicationJob
  queue_as :default

  # Fails assuming there is no school today
  def failure_with_assumption
    puts 'ResolveDayColorJob | Unable to find element for current date on infinite campus.
      School is likely not in session today.'
    Capybara.current_session.reset!
    Day.today.update(color: 'No Color')
  end

  def perform(*args)
    browser = Capybara.current_session
    browser.visit 'https://ic.syosset.k12.ny.us/'
    browser.find('#username').set(ENV['IC_USERNAME'])
    browser.find('#password').set(ENV['IC_PASSWORD'])
    browser.click_button('signinbtn')

    browser.within_frame 'frameDetail' do
      begin
       browser.click_link('attendance')
     rescue Capybara::ElementNotFound
       failure_with_assumption
       return
     end
    end

    browser.within_frame 'frameDetail' do
      begin
        today = Time.find_zone!('America/New_York').today
        browser.find(:xpath, "//span[contains(text(),\'#{today.strftime("%B")}\')]/../../..")
          .first('td', text: "#{today.day}").click()
      rescue NoMethodError
        failure_with_assumption
        return
      ensure
      end
    end

    browser.within_frame 'frameDetail' do
      begin
        color = browser.find('td', id: 'dow').text.split('(')[1].chomp(')') # Ex: 'Friday (W Day)' -> W Day

        if color == 'R Day'
          color = 'Red Day'
        else
          color = 'White Day'
        end

        puts 'ResolveDayColorJob | Today was determined to be a ' + color
        Day.today.update(color: color)
      rescue NoMethodError, Capybara::ElementNotFound
        failure_with_assumption
        return
      ensure
      end
    end

    Capybara.current_session.reset!
  end
end
