require './spec/helper'

describe Theme do

  it 'returns the css file name' do
    theme = Theme.new('foobar')
    filename = File.join(Coco::ROOT, 'template/css/foobar.css')
    expect(theme.filename).to eq filename
  end
end
