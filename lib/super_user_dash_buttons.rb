# Expected button in super user dashboard. Compared to actual in
# core/user_login_spec.rb
module SuperUserDashButtons
  ARM = ['Edit', 'Manage Content', 'Destroy']
  SSARM = ['EDIT', 'MANAGE CONTENT', 'DESTROY']
  TFDGROUP = ['Arm', 'Patient Dashboard', 'Messaging', 'Manage Tasks', 'Edit',
              'Destroy']
  TFDSOGROUP = ['Arm', 'Patient Dashboard', 'Messaging', 'Manage Tasks', 'Edit',
                'Destroy', 'Group Dashboard', 'Moderate',
                'Manage Profile Questions']
  SSGROUP = ['ARM', 'PATIENT DASHBOARD', 'MESSAGING', 'MANAGE TASKS', 'EDIT',
             'DESTROY', 'GROUP DASHBOARD', 'MODERATE', 'MANAGE INCENTIVES',
             'MANAGE PROFILE QUESTIONS']
end
