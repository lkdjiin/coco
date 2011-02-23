module Coco

  module Filename
    def Filename.rb2html name
      name.sub(Dir.pwd, '').tr('/\\', '_') + '.html'
    end
  end
  
end
