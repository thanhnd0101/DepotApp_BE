module DamView
  class CreateLineItemService

    private
    def set_line_item
      @line_item = LineItem.find(session[:line_item_id])
    rescue
      @line_item = LineItem.create
      session[:line_item_id] = @line_item.id
    end
  end
end
