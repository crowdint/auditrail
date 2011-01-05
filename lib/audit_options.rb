module Auditrail
  module ClassMethods
    class AuditOptions
  
      def initialize(&block)
        instance_eval &block if block
      end
  
      def user
        @user
      end
  
      def attributes
        @attributes
      end
  
      private
      def by_user(user = nil, &block)
        @user = block ? block.call : user
      end
  
      def for_attributes(*attributes)
        @attributes = attributes
      end
    end
  end
end