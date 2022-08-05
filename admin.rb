require 'colorize'
require_relative 'items'

module AdminPage

  def admin_menu
    Items.clear
    puts "Please select option what you want to do: ".green
    puts "1. View all items."
    puts "2. Add any item."
    puts "3. Remove any item."
    puts "4. Find any item."
    puts "5. View all users."
    puts "6. Logout!"
    puts "0. Close!"
    admin_selection = gets.chomp.to_i
    Items.clear
    case admin_selection
    when 1
      Items.display_all
    when 2
      add_item
    when 3
      puts "Please enter name, what you want to remove: "
      print "Item Name: "
      name = gets.strip

      puts "How many #{name} do you want to remove: "     
      print "#{name} Quantity: "
      quantity = gets.strip.to_i

      delete_item(name, quantity)
    when 4
      find_item
    when 5
      Users.display_all
    when 6
      Login.user_selection
    when 0
      exit!
    else
      puts "Please select valid option..".red
      admin_menu
    end
    puts "Enter any key to continue: ".red
    gets
    admin_menu
  end

  def cancel_method
    puts "Do you want to add another item to your Vending Machine.: "
    puts "if 'Yes' so Press - 1"
    puts "if 'No' so Press - 2"
    cancel = gets.chomp.to_i
    puts ""
    if cancel.eql? 1
      add_item
    elsif cancel.eql? 2
      admin_menu
    else
      puts "Please enter valid input.".red
      cancel_method
    end
  end

  def add_item
    puts "Please Enter item name: "
    name = gets.strip
    puts "Please Enter #{name} price: "
    price = gets.strip.to_i
    puts "Please Enter #{name} quantity: "
    quantity = gets.strip.to_i
    if name.empty? || price == 0 || quantity == 0
      puts "Please fill in all the required fields.\n".red
      add_item 
    else
      Items.create(name, price, quantity)
      puts "#{quantity} #{name} added successfully.\n".green
      cancel_method 
    end 
  end

  def find_item
    puts "Please Enter Item what do you want to find: ".green
    name = gets.strip
    unless Items.find_by(name).nil? 
      puts "Id|Name | Price | Quantity"
      Items.find_by(name)&.display
    else
      puts "!!Item does not exist!!".red
    end
  end

  def delete_item(name, quantity)
    item = Items.find_by(name)
    return puts "Item not available!!\n".red if item.nil?
    return_qty = item.decrement_quantity_by!(quantity)
    if return_qty >= 0
      puts "=> Please collect your #{count} #{name}.".green
    else
      return
   end
  end
end
