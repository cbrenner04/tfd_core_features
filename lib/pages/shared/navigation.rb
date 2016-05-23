# module for shared navigation
module SharedNavigation
  include Capybara::DSL

  def scroll_to_bottom
    execute_script('window.scrollTo(0,5000)')
  end

  def scroll_down
    execute_script('window.scrollBy(0,500)')
  end

  def confirm_with_js
    execute_script('window.confirm = function() {return true}')
  end

  def next
    click_on 'Next'
  end

  def host_app
    if ENV['tfd'] || ENV['tfdso']
      'ThinkFeelDo'
    elsif ENV['sunnyside']
      'Sunnyside'
    elsif ENV['marigold']
      'Marigold'
    end
  end

  def click_on_login_page_slideshow
    click_on "Introduction to #{host_app}"
  end

  def done
    click_on 'Done'
  end

  def click_brand
    find(:css, '.navbar-brand').click
  end
end