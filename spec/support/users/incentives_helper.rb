require './lib/pages/users/arms'
require './lib/pages/users/groups'
require './lib/pages/users/incentives'

def arm_1
  @arm_1 ||= Users::Arms.new(title: 'Arm 1')
end

def group_1
  @group_1 ||= Users::Groups.new(title: 'Group 1')
end

def group_6
  @group_6 ||= Users::Groups.new(title: 'Group 6')
end

def group_9
  @group_9 ||= Users::Groups.new(title: 'Group 9')
end

def group_6_incentives
  @group_6_incentives ||= Users::Incentives.new(group: 'Group 6')
end

def group_9_incentives
  @group_9_incentives ||= Users::Incentives.new(group: 'Group 9')
end
