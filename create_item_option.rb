require_relative 'menu_option'

# create item option
class CreateItemOption < MenuOption
  def execute
    @app.create_item
  end

  def name
    'Create an Item'
  end
end
