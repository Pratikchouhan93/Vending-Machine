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
      if Items.all.empty?()
        puts "Vending Machine is empty!!".red
      else
        puts "Id | Name | Price | Quantity"
        Items.all.each do |item|
          puts "#{item.id}-   #{item.name}   #{item.price}      #{item.quantity}"
        end
      end
    when 2
      add_item_task
    when 3
      puts "Please enter name, what you want to remove: "
      print "Item Name: "
      name = gets.strip

      puts "How many #{name} do you want to remove: "     
      print "#{name} Quantity: "
      quantity = gets.strip.to_i

      delete_item_task(name, quantity)
    when 4
      find_item_task
    when 5
      Login.login_selection
    when 6
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
    name = gets.strip
    puts "Please Enter #{name} price: "
    price = gets.strip.to_i
    puts "Please Enter #{name} quantity: "
    quantity = gets.strip.to_i
    if name.empty? || price == 0 || quantity == 0
      puts "Please fill in all the required fields.\n".red
      add_item_task 
    else
      Items.create(name, price, quantity)
      puts "#{quantity} #{name} added successfully.\n".green
      cancel_method 
    end 
  end

  def find_item_task
    puts "Please Enter Item what do you want to find: ".green
    name = gets.strip
    unless Items.find_by(name).empty?
      puts "Id|Name | Price | Quantity"
      Items.find_by(name).each { |item| 
        puts "#{item.id}-   #{item.name}   #{item.price}      #{item.quantity}" }
      else
        puts "!!Item does not exist!!".red
      end
    end

    def delete_item_task(name, quantity)
      find_arr = Items.find_by(name)
      if find_arr.empty?
        puts "Item not available!!\n".red
      else
        find_arr.find { |item| 
          if item.quantity >= quantity
            item.quantity -= quantity
            puts "=> Please collect your #{quantity} #{name}.".green
          else
            puts "Sorry only #{item.quantity} #{name} left.".red
          end
        }
      end
    end
  end