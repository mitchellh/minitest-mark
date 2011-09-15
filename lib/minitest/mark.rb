# TODO

module MiniTest
  module Mark
    # Allow `include` or `extend` to work with our module.
    def self.included(cls)
      cls.extend(ClassMethods)
    end

    def self.extended(cls)
      cls.extend(ClassMethods)
    end

    module ClassMethods
      # This is a magic lifecycle hook which keeps track of when
      # methods are added, useful for matching up marks with test
      # methods.
      def method_added(name)
        @marks ||= {}
        @marks[name.to_s] = @_next_marks
        @_next_marks = nil
      end

      # Mark a test!
      def mark(mark_string)
        @_next_marks ||= []
        @_next_marks << mark_string
      end

      def test_methods
        results = super

        # If the MARK environmental variable is fine, we restrict by
        # mark.
        if ENV["MARK"]
          # If we don't have any marks then we have no tests
          return [] if !@marks

          interested_marks = ENV["MARK"].split(",")

          results.select! do |name|
            next false if !@marks[name]

            found = interested_marks.find do |single_mark|
              @marks[name].include?(single_mark)
            end

            # Success if we found a mark
            !found.nil?
          end
        end

        results
      end
    end
  end
end
