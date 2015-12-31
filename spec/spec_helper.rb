require 'serverspec'

set :backend, :exec

def homedir
  File.expand_path('~')
end

def basedir
  File.expand_path('../../', __FILE__)
end

def full_files
  # Don't use glob because install.sh create symlink by glob.
  Dir.entries("#{basedir}/home")
    .reject { |f| f.include?('slim') }
    .reject { |f| f.start_with?('.') && f.end_with?('.') }
end

def slim_files
  Dir.entries("#{basedir}/home")
    .select { |f| f.include?('slim') }
end
