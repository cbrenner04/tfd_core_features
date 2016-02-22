require './lib/pages/participants/navigation'

class Participants
  # page object for Relax tool
  class Relax
    include Capybara::DSL

    def landing_page
      visit "#{ENV['Base_URL']}/navigator/contexts/RELAX"
    end

    def visible?
      has_text? 'RELAX Home'
    end

    def open_autogenic_exercises
      click_on 'Autogenic Exercises'
    end

    def play_audio
      find('.jp-controls').find('.jp-play').click
    end

    def finish
      navigation.next
      visible?
    end

    private

    def navigation
      @navigation ||= Participants::Navigation.new
    end
  end
end
