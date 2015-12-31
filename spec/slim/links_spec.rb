require 'spec_helper'

slim_files.each do |f|
  describe file(f.linkpath) do
    it { should be_symlink }
    it { should be_linked_to f.targetpath }
  end
end

slim_link_basenames = slim_files.map(&:linkpath).map { |f| File.basename(f) }
unneeded_files = full_files.reject { |f| slim_link_basenames.include?(File.basename(f)) }
p unneeded_files
unneeded_files.each do |f|
  describe file(f.linkpath) do
    it { should_not exist }
  end
end
