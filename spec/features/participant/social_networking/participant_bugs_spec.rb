# file: ./spec/features/participant/social_networking/participant_bugs_spec.rb

feature 'Social Networking Bugs, Non-social Participant',
        :social_networking, :marigold, sauce: sauce_labs do
  background do
    sign_in_pt(ENV['NS_Participant_Email'], 'participant1',
               ENV['NS_Participant_Password'])
  end

  scenario 'Participant cannot select My Profile from navbar dropdown' do
    within '.navbar-collapse' do
      find('.fa.fa-user.fa-lg')
      expect(page).to_not have_content 'My Profile'
    end

    sign_out('nonsocialpt')
  end
end
