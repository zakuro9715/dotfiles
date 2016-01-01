require 'spec_helper'

slim_files.each do |f|
  describe file(f.linkpath) do
    it { should be_symlink }
    it { should be_linked_to f.targetpath }
  end
end
