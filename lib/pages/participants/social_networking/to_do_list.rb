class Participants
  class SocialNetworking
    # page object for the to do list
    class ToDoList
      include Capybara::DSL

      def initialize(to_do_list_arry)
        @task ||= to_do_list_arry[:task]
      end

      def visible?
        has_css?('.panel-title', text: 'To Do')
      end

      def has_profile_task?
        has_text? 'Create a Profile'
      end

      def select_task
        click_on @task
      end
    end
  end
end
