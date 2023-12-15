
require_relative 'menu_option'

class ListAllLabels < MenuOption
  def execute
    @app.list_all_labels
  end

  def name
    'List all labels'
  end
end