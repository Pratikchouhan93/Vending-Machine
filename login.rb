require_relative 'admin'
require_relative 'customer'
require_relative 'users'
require_relative 'seed'
require 'terminal-table'
require 'colorize'

class Login
  extend AdminPage
  extend CustomerPage

  class << self

    def welcome_screen
      puts ""
      puts "***************======================================***************".center(144)
      puts "!! Welcome to our Vending Machine !!".center(144)
      puts "***************======================================***************".center(144) 
    end

    def user_login_signup
      puts "Please select one of these options: "
      puts "\n1. LOGIN"
      puts "2. SIGN UP"
      puts "0. Go Back"
      login_signup = gets.strip.to_i

      Items.clear
      case login_signup

        when 1
          puts "Please enter your email: "
          email = gets.strip
          puts "Please enter your password: "
          password = gets.strip
          unless Users.authenticate(email, password).nil?
            Login.customer_menu
          else
            puts "Please enter valid details or sign up.\n".red
            user_login_signup
          end 
        when 2
          Items.clear
          Login.user_sign_up
        when 0
          Login.user_selection
        else
          puts "* Please select valid option....".red
          user_login_signup
      end
    end

    def admin_login
      puts "Please enter your email: "
      email = gets.strip
      puts "Please enter your password: "
      pass = gets.strip
      if (email.eql? "admin.com") && (pass.eql? "12345")
        Login.admin_menu
      else
        puts "Please Enter Correct Email & Password !!".red
        admin_login
      end
    end

    def user_sign_up
      puts "Please enter your name: "
      name = gets.strip
      puts "Please enter your email: "
      email = gets.strip
      puts "Please create your password: "
      password1 = gets.strip
      puts "Please re-enter your password: "
      password2 = gets.strip
      
      if password1.eql? password2
        Items.clear
        puts "Congratulations, your account has been successfully created.\n".green
        Users.create(name,email,password1)
        Login.user_login_signup
      else
        puts "Password and confirm password does not match. Please re-enter details!!".red
        user_sign_up
      end
    end

    def user_selection
      puts "Please select one of these options: "
      puts "\n1. I am Admin."
      puts "2. I am Customer."
      puts "0. I want to Quit."
      user_select = gets.chomp.to_i
      Items.clear
      case user_select
      when 1
        puts "Please Login First:".green
        admin_login
      when 2
        Login.user_login_signup
      when 0
        exit!
      else
        puts "* Please select valid option....".red
        user_selection
      end
    end  
  end
end

Login.welcome_screen
Login.user_selection
