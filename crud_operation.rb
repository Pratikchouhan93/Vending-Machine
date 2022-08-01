module ItemsModule
  class Items
    ALL_ITEMS = [] 
    attr_accessor :id, :name, :price
    
    def initialize(name, price)
      @id = set_incremental_id
      @name = name
      @price = price
      ALL_ITEMS << self
    end
    
    def set_incremental_id
      (ALL_ITEMS.last&.id || 0) + 1
    end

    def destroy
      ALL_ITEMS.delete(self)
    end

    class << self
      def create(name, price)
        new(name, price)
      end

      def find_by(name)
        all.select {|item| item.name == name}
      end

      def all
        ALL_ITEMS
      end
    end
  end
end

# [ 
#   ["Pepsi", 1],
#   ["Pepsi", 20],
#   ["Pepsi", 130],
#   ["Pepsi", 11],
#   ["Pepsi", 31],
#   ["Pepsi", 51]
# ].each do |name, price|
 
#   ItemsData::Items.create(name, price)
# end

# puts "Id Name Price"
# ItemsData::Items.all.each do |item|
#   puts "#{item.id} #{item.name} #{item.price}"
# end
