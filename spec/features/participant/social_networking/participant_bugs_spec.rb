# file: ./spec/features/participant/social_networking/participant_bugs_spec.rb

describe 'Social Networking Bugs', :social_networking,
         type: :feature, sauce: sauce_labs do
  describe 'Active participant in group 5 signs in,' do
    before do
      sign_in_pt(ENV['NS_Participant_Email'], 'participant1',
                 ENV['NS_Participant_Password'])
    end

    it 'cannot select My Profile from navbar dropdown' do
      within '.navbar-collapse' do
        find('.fa.fa-user.fa-lg')
        expect(page).to_not have_content 'My Profile'
      end

      sign_out('nonsocialpt')
    end
  end
end
