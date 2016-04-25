module ActiveRecordExtension

  extend ActiveSupport::Concern

  # add your static(class) methods here
  module ClassMethods

    def all_polymorphic_types(name)
      @poly_hash ||= {}.tap do |hash|
        Dir.glob(File.join(Rails.root, "app", "models", "**", "*.rb")).each do |file|
          klass = (File.basename(file, ".rb").camelize.constantize rescue nil)
          next if klass.nil? or !klass.ancestors.include?(ActiveRecord::Base)
          klass.reflect_on_all_associations(:has_many).select{|r| r.options[:as] }.each do |reflection|
            (hash[reflection.options[:as]] ||= []) << klass
          end
        end
      end
      @poly_hash[name.to_sym]
    end

  end
end

# include the extension
ActiveRecord::Base.send(:include, ActiveRecordExtension)