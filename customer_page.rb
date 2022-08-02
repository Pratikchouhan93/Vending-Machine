require 'colorize'
require_relative 'crud_operation'
module CustomerPage
  def customer_menu
    puts "Please select option what you want to do: ".green
    puts "1. View all items."
    puts "2. Find any item."
    puts "3. Buy any item."
    puts "4. Logout!"
    puts "5. Close!"

    customer_selection = gets.chomp.to_i
    Items.clear

    case customer_selection
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
      find_item_task
    when 3
      puts "Please enter item name, what you want to buy: "
      print "Item Name: "
      name = gets.strip

      puts "How many #{name} do you want to buy: "     
      print "#{name} Quantity: "
      quantity = gets.strip.to_i

      buy_item_task(name, quantity)
    when 4
      Login.login_selection
    when 5
      exit!
    else
      puts "Please select valid option..".red
      customer_menu
    end
    puts "Enter any key to continue: ".red
    gets
    customer_menu
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

  def buy_item_task(name, quantity)
    find_arr = Items.find_by(name)
    if find_arr.empty?
      puts "Item not available!!\n".red
    else
      find_arr.find { |item| 
        if item.quantity >= quantity
          bill_request(item.name, item.price, quantity, find_arr)
        else
          puts "Sorry only #{item.quantity} #{name} left.".red
        end
      }
    end
  end

  def bill_request(name, price, quantity, find_arr)
    cost = price * quantity
    puts "You have to pay #{cost} rupees.".green
    continue_method
    bill_amount(name, cost, quantity, find_arr)
  end

  def continue_method
    puts "Press 1 to continue or 2 to cancel the order: ".green
    cancel = gets.strip.to_i
    puts ""
    if cancel.eql? 1
      return
    elsif cancel.eql? 2
      customer_menu
    else
      puts "Please enter valid input.".red
      continue_method
    end
  end

  def bill_amount(name, cost, quantity, find_arr)
    puts "Please enter money: "
    amount = gets.strip.to_i
    total_amount = add_more_money(amount)
    puts "Total money paid by you is Rs: #{total_amount}"
    if cost < total_amount
      puts "=> Please collect your #{quantity} #{name}.".green
      change = total_amount - cost
      puts "Please collect your change: #{change} rupees.".green
      puts "=========Thank You for using our Vending Machine=========".red
      find_arr.find { |item| item.quantity -= quantity }
    elsif cost == total_amount
      puts "=> Please collect your #{quantity} #{name}.".green
      puts "=========Thank You for using our Vending Machine=========".red
      find_arr.find { |item| item.quantity -= quantity }
    else
      puts "Order Failed!! - You have entered less money.!!".red
      customer_menu
    end
  end

  def add_more_money(amount)
    puts "If you want to add more money then press 1 or press 2 to proceed: "
    cancel = gets.strip.to_i
    puts ""
    if cancel.eql? 1
      puts "Please enter money: "
      repeat_amount = gets.strip.to_i
      amount += repeat_amount
      add_more_money(amount)
    elsif cancel.eql? 2
      return amount
    else
      puts "Please enter valid input.".red
      continue_method
    end
  end
end