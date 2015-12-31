require 'spec_helper'

full_files.each do |f|
  describe file("#{homedir}/#{f}") do
    it { should be_symlink }
    it { should be_linked_to "#{basedir}/home/#{f}" }
  end
end

slim_files.each do |f|
  describe file("#{homedir}/#{f}") do
    it { should_not exist }
  end
end
