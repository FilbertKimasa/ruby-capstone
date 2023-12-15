require_relative 'menu_option'

# create item option
class CreateItemOption < MenuOption
  def execute
    @app.add_item
  end

  def name
    'Create an Item'
  end
end
