module Coco

  module Filename
    def rb2html name
      name.sub(Dir.pwd, '').tr('/\\', '_') + '.html'
    end
  end
  
end
