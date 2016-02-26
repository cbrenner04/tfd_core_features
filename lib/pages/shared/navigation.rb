# module for shared navigation
module SharedNavigation
  include Capybara::DSL

  def scroll_to_bottom
    execute_script('window.scrollTo(0,5000)')
  end

  def scroll_down
    execute_script('window.scrollBy(0,500)')
  end
end
