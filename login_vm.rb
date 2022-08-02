require_relative 'admin_page'
require_relative 'customer_page'
require 'colorize'
class Login
  extend AdminPage
  extend CustomerPage
  def self.welcome_screen
    puts ""
    puts "===================================================================".center(144)
    puts "!! Welcome to our Vending Machine !!".center(144)
    puts "===================================================================".center(144) 
  end

  def self.login_selection
    puts "Please select one of these options: "
    puts "\n1. I am Admin."
    puts "2. I am Customer."
    puts "0. I want to Quit."
    user_select = gets.chomp.to_i
    Items.clear
    case user_select
    when 1
      Login.admin_menu
    when 2
      Login.customer_menu
    when 0
      exit!
    else
      puts "* Please select valid option....".red
      login_selection
    end
  end
end

Login.welcome_screen
Login.login_selection