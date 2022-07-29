require 'colorize'
require_relative 'linked_list'
include ItemsModule
module AdminPage
  def admin_menu
    puts "Please select option what you want to do: \n".green
    puts "1. View all items."
    puts "2. Add any item."
    puts "3. Remove any item."
    puts "4. Logout!"
    puts "5. Close!"
    admin_selection = gets.chomp.to_i
    case admin_selection
    when 1
      puts "Id Name Price"
      ItemsModule::Items.all.each do |item|
      puts "#{item.id}- #{item.name} #{item.price}"
      end
    when 2
      add_item_task
    when 3
    when 4
      # LoginModule.welcome_screen
    when 5
    else
      puts "Please select valid option..".red
      admin_menu
    end
  end

  def cancel_method
    puts "Do you want to add another item to your Vending Machine.: "
    puts "if 'Yes' so Press - 1"
    puts "if 'No' so Press - 2"
    cancel = gets.chomp.to_i
    puts ""
    if cancel.eql? 1
      add_item_task
    elsif cancel.eql? 2
      admin_menu
    else
      puts "Please enter valid input."
      cancel_method
    end
  end

  def add_item_task
    puts "Please Enter item name: "
    item_name = gets.chomp 
    puts "Please Enter item price: "
    item_price = gets.chomp.to_i
    ItemsModule::Items.create(item_name, item_price)
    puts "1 item added successfully.\n"
    cancel_method  
  end
end