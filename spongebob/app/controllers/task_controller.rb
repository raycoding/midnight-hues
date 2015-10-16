class TaskController < WebsocketRails::BaseController
  def create
    # The `message` method contains the data received
    c = PriceDetails.new()
    puts "hi #{c}"
    if c.save
      WebsocketRails[:tasks].trigger 'create_success', c
    end
  end
end