#strongly modeled after the install_generator.rb file located in gregbell/active_admin repository on github

module StatusDashboard
  module Generators
    class InstallGenerator < Rails::Generators::Base
    
      include Rails::Generators::Migration
      
      def self.source_root
        @_status_dashboard_source_root ||= File.expand_path("../templates", __FILE__)
      end
      
      def self.next_migration_number(dirname)
        Time.now.strftime("%Y%m%d%H%M%S")
      end
      
      def modify_active_admin_defaults
        copy_file 'dashboards.rb', 'app/admin/dashboards.rb'
        copy_file 'posts.rb', 'app/admin/posts.rb'
      end
      
      def create_generic_index
        copy_file 'index.html.erb', 'app/views/status/index.html.erb'
      end
      
      def create_config_files
        create_file 'config/newrelic_api.yml' do
          'newrelic_api:
  api_key:
  account_id:'
        end
        
        create_file 'config/hoptoad_api.yml' do
          'hoptoad_api:
  auth_token:
  site_url:
  error_frequency_minimum: 0
  error_expiry_time_in_minutes: 5'
        end
      end
      
      def create_migrations
        Dir["#{self.class.source_root}/migrations/*.rb"].sort.each do |filepath|
          name = File.basename(filepath)
          migration_template "migrations/#{name}", "db/migrate/#{name.gsub(/^\d+_/,'')}"
          sleep 1
        end
      end
      
    end
  end
end
