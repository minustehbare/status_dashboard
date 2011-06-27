Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'status_dashboard'
  s.version     = '0.0.1'
  s.summary     = 'Gem to create a basic status dashboard for an application using NewRelic RPM'
  s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'minustehbare'
  s.email             = 'minustehbare@gmail.com'
  # s.homepage          = 'http://www.rubyonrails.org'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('rails', '>= 3.0.7')
  s.add_dependency('paperclip', '~> 2.3')
  s.add_dependency('activeadmin')
  s.add_dependency('will_paginate', '~> 3.0.pre2')
  s.add_dependency('rdiscount')
end
