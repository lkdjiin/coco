require './spec/helper'

describe SourceLister do

  subject { SourceLister.new(Configuration.new) }

  after :each do
    FileUtils.rm '.coco.yml', :force => true
  end

  it "accepts a list of folder" do
    create_config({:include => ['lib', 'spec']})
    expect { subject }.not_to raise_error
  end

  it "accepts a single folder" do
    create_config(:include => 'lib')
    expect { subject }.not_to raise_error
  end

  it "raises an error if a folder doesnt exist" do
    create_config(:include => ['lib', 'unknown'])
    expect { subject }.to raise_error(ArgumentError)
  end

  describe '#list' do
    let(:list) { subject.list }

    def assert_list(list, size: 1)
      expect(list.size).to eq(size)
      expect(list).to all(match(/\.rb$/))
    end

    it "lists the rb sources from a single folder" do
      create_config(:include => 'spec/project/3_rb_files', :exclude => [])
      assert_list(list, size: 3)
    end

    it "lists the rb sources user dont want" do
      create_config(:include => 'spec/project/3_rb_files',
                    :exclude => ['spec/project/3_rb_files/1.rb'])
      assert_list(list, size: 2)
    end

    it "lists the rb sources from a list of folders" do
      create_config(:include => ['spec/project/3_rb_files',
                                     'spec/project/4_rb_files'],
                    :exclude => [])
      assert_list(list, size: 7)
    end

    it "excludes a whole directory" do
      create_config(:include => 'spec/project',
                    :exclude => ['spec/project/3_rb_files',
                                  'spec/project/4_rb_files'])
      list.map! {|x| File.basename(x)}

      expect(list).to include('html_entities.rb',
                              'six_lines.rb',
                              'ten_lines.rb')
    end

  end

end
