require 'colorize'
require_relative 'items'

module CustomerPage

  def customer_menu
    Items.clear
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
      find_item
    when 3
      puts "Please enter item name, what you want to buy: "
      print "Item Name: "
      name = gets.strip

      puts "How many #{name} do you want to buy: "     
      print "#{name} Quantity: "
      quantity = gets.strip.to_i
      item_qty = Items.find_by(name)&.quantity
      if item_qty >= quantity
        buy_item(name, quantity)
      else
        puts "Sorry only #{item_qty} #{name} left.".red
      end
    when 4
      Login.user_selection
    when 5
      exit!
    else
      puts "Please select valid option..".red
      customer_menu
    end
    print "Enter any key to continue: ".red
    gets
    customer_menu
  end

  def buy_item(name, quantity)
    item_arr = Items.find_by(name)
    return puts "Item not available!!\n".red if item_arr.nil?
    bill_request(item_arr.name, item_arr.price, quantity, item_arr)
  end

  def bill_request(name, price, quantity, item_arr)
    cost = price * quantity
    puts "You have to pay #{cost} rupees.".green
    continue_method
    bill_amount(name, cost, quantity, item_arr)
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

  def bill_amount(name, cost, quantity, item_arr)
    puts "Please enter money: "
    amount = gets.strip.to_i
    amount = add_more_money(amount)
    puts "Total money paid by you is Rs: #{amount}"
    if cost < amount
      puts "=> Please collect your #{quantity} #{name}. <=".green.center(144)
      change = amount - cost
      puts "=> Please collect your change: #{change} rupees. <=".green.center(144)
      puts "=========Thank You for using our Vending Machine=========".red.center(144)
      item_arr.decrement_quantity_by!(quantity)
    elsif cost == amount
      puts "=> Please collect your #{quantity} #{name}.".green.center(144)
      puts "=============Thank You for using our Vending Machine=============".red.center(144)
      item_arr.decrement_quantity_by!(quantity)
    else
      puts " Order Failed!! - You have entered less money.!!\n".red.center(144)
      puts "=> Please collect your money: #{amount} rupees. <=".green.center(144)
      puts "=============Thank You for using our Vending Machine=============".red.center(144)
      print "Enter any key to continue: ".red.center(144)
      gets
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
      return add_more_money(amount)
    end
  end
end