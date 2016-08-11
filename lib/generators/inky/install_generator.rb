require 'rails/generators'

module Inky
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc 'Install Foundation for Emails'
      source_root File.join(File.dirname(__FILE__), 'templates')
      argument :layout_name, :type => :string, :default => 'mailer', :banner => 'layout_name'
      argument :extension,   :type => :string, :default => 'erb',    :banner => 'extension'

      def preserve_original_mailer_layout
        return nil unless layout_name == 'mailer'

        original_mailer = File.join(layouts_base_dir, "mailer.html.#{extenstion}")
        rename_filename = File.join(layouts_base_dir, "old_mailer_#{Time.now.to_i}.html.erb")
        File.rename(original_mailer, rename_filename) if File.exists? original_mailer
      end

      def create_mailer_stylesheet
        template 'foundation_emails.scss', File.join(stylesheets_base_dir, 'foundation_emails.scss')
      end

      def create_mailer_layout
        template "mailer_layout.html.#{extension}", File.join(layouts_base_dir, "#{layout_name.underscore}.html.#{extension}")
      end

      private

      def stylesheets_base_dir
        File.join('app', 'assets', 'stylesheets')
      end

      def layouts_base_dir
        File.join('app', 'views', 'layouts')
      end
    end
  end
end
