module Coco

  class Theme

    def initialize(name)
      @name = "#{name}.css"
    end

    def filename
      File.join(Coco::ROOT, 'template/css', @name)
    end

  end
end
