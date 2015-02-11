module MethodTags
  def self.included(base)
    puts base
    base.extend ClassMethod
    base.include InstanceMethod
  end

  module ClassMethod
    private
    def _tag_(*names)
      @last_names = names
    end

    def method_added(method_name)
      @method_tags ||= {}
      unless instance_variable_defined? :@last_names
        @last_names = []
      end
      @last_names.each do |nm|
        @method_tags[nm] ||= []
        @method_tags[nm] << method_name
      end

      remove_instance_variable :@last_names
    end
  end

  module InstanceMethod
    private
    def tagged_methods(tag_name)
      tags = self.class.instance_variable_get :@method_tags
      tags ? tags[tag_name] : []
    end
  end
end
