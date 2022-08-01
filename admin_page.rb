require 'colorize'
require_relative 'crud_operation'
module AdminPage
  def admin_menu
    puts "Please select option what you want to do: ".green
    puts "1. View all items."
    puts "2. Add any item."
    puts "3. Remove any item."
    puts "4. Find any item."
    puts "5. Logout!"
    puts "6. Close!"
    admin_selection = gets.chomp.to_i
    Items.clear
    case admin_selection
    when 1
      puts "Id Name Price"
      Items.all.each do |item|
        puts "#{item.id}- #{item.name} #{item.price}"
      end
    when 2
      add_item_task
    when 3
      puts "Please enter name and price, what you want to delete: "
      print "name:  "
      name = gets.chomp
      print "price:  "
      price = gets.chomp.to_i
      puts ""
      # delete_item_task(name, price)
      puts "Item Deleted."
    when 4
      find_item_task
    when 5
      # LoginModule.welcome_screen
    when 6
      exit!
    else
      puts "Please select valid option..".red
      admin_menu
    end
    puts "Enter any key to continue: ".green
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
      add_item_task
    elsif cancel.eql? 2
      admin_menu
    else
      puts "Please enter valid input.".red
      cancel_method
    end
  end

  def add_item_task
    puts "Please Enter item name: "
    item_name = gets.chomp 
    puts "Please Enter item price: "
    item_price = gets.chomp.to_i
    Items.create(item_name, item_price)
    puts "1 item added successfully.\n"
    cancel_method  
  end

  def find_item_task
    puts "Please Enter Item what do you want to find: ".green
    name = gets.chomp
    unless Items.find_by(name).empty?
      Items.find_by(name).each { |item| 
      puts "#{item.id}- #{item.name} #{item.price}" }
    else
      puts " !!Item does not exist!! ".red
    end
  end

  def delete_item_task(name, price)
    # unless Items.find_by(name).empty?
    delete_obj = Items::ALL_ITEMS.select { |item| 
      item.name == name
      item.price == price }
    Items::ALL_ITEMS.delete(delete_obj)
    # Items.new(name, price).destroy
    # else
    #   puts " !!Item does not exist!! ".red
    # end
  end
end