require "minitest/unit"

# This is the only file that needs to be included when enabling
# minitest-mark.
module MiniTest
  module Mark
    def self.included(cls)
      cls.extend(ClassMethods)

      # Yeah, this is an alias_method_chain. Don't judge me.
      cls.class_eval do
        class << self
          alias_method :test_methods_without_mark, :test_methods
          alias_method :test_methods, :test_methods_with_mark
        end
      end
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

      # Mark a test.
      def mark(mark_string)
        @_next_marks ||= []
        @_next_marks << mark_string
      end

      # This method returns the test methods for this test suite. This is
      # overridden from the parent to check for the MARK environmental
      # variable and return only correct tests.
      def test_methods_with_mark
        results = test_methods_without_mark

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

# Force MiniTest TestCase to include the marking framework.
MiniTest::Unit::TestCase.send(:include, MiniTest::Mark)
