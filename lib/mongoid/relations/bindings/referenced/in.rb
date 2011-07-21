# encoding: utf-8
module Mongoid # :nodoc:
  module Relations #:nodoc:
    module Bindings #:nodoc:
      module Referenced #:nodoc:

        # Binding class for all referenced_in relations.
        class In < Binding

          # Binds the base object to the inverse of the relation. This is so we
          # are referenced to the actual objects themselves on both sides.
          #
          # This case sets the metadata on the inverse object as well as the
          # document itself.
          #
          # @example Bind the documents.
          #   game.person.bind(:continue => true)
          #   game.person = Person.new
          #
          # @since 2.0.0.rc.1
          def bind
            base.send(metadata.foreign_key_setter, target.id)
            if metadata.inverse_type
              base.send(metadata.inverse_type_setter, target.class.model_name)
            end
          end
          alias :bind_one :bind

          # Unbinds the base object and the inverse, caused by setting the
          # reference to nil.
          #
          # @example Unbind the document.
          #   game.person.unbind(:continue => true)
          #   game.person = nil
          #
          # @since 2.0.0.rc.1
          def unbind
            base.do_or_do_not(metadata.foreign_key_setter, nil)
            if metadata.inverse_type
              base.send(metadata.inverse_type_setter, nil)
            end
          end
          alias :unbind_one :unbind
        end
      end
    end
  end
end
