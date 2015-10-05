module ActiveModel
  class ForbiddenAttributesError < StandardError
  end

  module ForbiddenAttributesProtection
    protected
      def sanitize_for_mass_assignment(attributes)
      	#Please note I have changed the strict attributes permitted in Rails 4.
      	# ToDo: Remove this initializers after you have defined permitted attributes in all your controllers and models.
        
      	# This is the Original below
        # if attributes.respond_to?(:permitted?) && !attributes.permitted?
        #   raise ActiveModel::ForbiddenAttributesError
        # else
        #   attributes
        # end
        attributes
      end
      alias :sanitize_forbidden_attributes :sanitize_for_mass_assignment
  end
end