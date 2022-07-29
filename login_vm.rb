require_relative 'admin_page'
require 'colorize'
include AdminPage
module LoginModule
  def welcome_screen
    puts ""
    puts "===================================================================".center(144)
    puts "!! Welcome to our Vending Machine !!".center(144)
    puts "===================================================================".center(144) 
  end

  def login_selection
    puts "Please select one of these options: \n\n"
    puts "1. I am Admin."
    puts "2. I am Customer."
    puts "0. I want to Quit."
    user_select = gets.chomp.to_i
    case user_select
      when 1
        return 1
      when 2
        return 2
      when 0
        exit!
      else
        puts "* Please select valid option....".red
        login_selection
    end
  end
end

class Login
  include LoginModule
  Login.new.welcome_screen
  def user_login
    user_selection = login_selection
    if user_selection.eql? 1
      AdminPage::admin_menu
    elsif user_selection.eql? 2
      puts "Customer"
    end
  end
end

Login.new.user_login