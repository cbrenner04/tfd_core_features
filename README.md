# ThinkFeelDo Core Features

This is a test suite that can be pointed at any of the ThinkFeelDo host apps:

* [ThinkFeelDo](https://github.com/cbitstech/think_feel_do)
* [ThinkFeelDoSo](https://github.com/cbitstech/think_feel_do_so)
* [SunnySide](https://github.com/cbitstech/sunnyside)
* [Marigold](https://github.com/NU-CBITS/marigold)

## Information for running this test suite

You will need to set up the following participants and users in the host app:

* Participant - an active participant with access to most tools (see tests
  for granular detail)
* Participant_2 - an active participant with access to FEEL > Tracking Your
  Mood & Emotions
* Old_Participant - an inactive participant
* Alt_Participant - an active participant with access to many tools (see tests
  for granular detail)
* NS_Participant - an active participant with access to many tools (see tests
  for granular detail)
* Completed_Pt - a participant who is an arm that does not allow messaging
  functionality after completion and is flagged as complete
* Mobile_Comp_Pt - a participant who is an arm that does not allow messaging
  functionality after completion and is flagged as complete
* PT61 - an active participant in a social arm
* Participant_5 - an active participant with access to most tools (see tests
  for granular detail)
* User - user given a super user role
* Clinician - user with a clinician role
* Researcher - user with a researcher role
* Content_Author - user with a content author role

You will need to set the following environment variables that correspond to
the participants and users above as well as a couple of pieces of data for
specific tests. These are set as environment variables to protect sensitive
data as well as access to the application. 

I have set up a `configure_cloud.rb` file that has each of these environment
variables defined which the test suite will reference.

The  `Participant_Phone_Number` variable is formatted 18885559999 while the
`Participant_Phone_Number_1` is formatted 1(888) 555-9999. The `Audio_File`
variable is a URL specific to the host app.

    Base_URL; Participant_Email; Participant_Password; Participant_2_Email;
    Participant_2_Password; PT61_Email; PT61_Password; Old_Participant_Email;
    Old_Participant_Password; Alt_Participant_Email; Alt_Participant_Password;
    NS_Participant_Email; NS_Participant_Password; Completed_Pt_Email;
    Completed_Pt_Password; Mobile_Comp_Pt_Email; Mobile_Comp_Pt_Password;
    PT61_Email; PT61_Password; Participant_5_Email; Participant_5_Password;
    User_Email; User_Password; Clinician_Email; Clinician_Password;
    Researcher_Email; Researcher_Password; Content_Author_Email;
    Content_Author_Password; Participant_Phone_Number;
    Participant_Phone_Number_1; Audio_File

To run on Sauce Labs you will need to set the following environment variables,
otherwise you can run it locally on your machine:

    SAUCE_USERNAME; SAUCE_ACCESS_KEY

To run the suite simply run:

    rpsec
