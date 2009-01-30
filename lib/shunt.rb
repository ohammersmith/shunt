$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Shunt
  VERSION = '0.0.1'
  
  
  def go(&proc)
    @shunt = Shunt.new
    yield @shunt
    
    if @shunt.control_exception.nil? && @shunt.variable_exception.nil?
      raise Spec::Expectations::ExpectationNotMetError.new("The code isn't broken, please break something.")
    elsif @shunt.control_exception.nil? && !@shunt.variable_exception.nil?
      raise Spec::Expectations::ExpectationNotMetError.new("The control spec passes, is the code under test broken?")
    elsif !@shunt.control_exception.nil? && @shunt.variable_exception.nil?
      raise Spec::Expectations::ExpectationNotMetError.new("The variable spec passes now.")
    end
    # should be where they both have failures and I should test them somehow
    # assuming I'm not delusional about how tired I am.
  end
  
  class Shunt  # TODO should this be the self construct, WTF is that anyway?
    
    attr_reader :control_exception
    attr_reader :variable_exception
    def control(&proc)
      begin
        proc.call
      rescue Exception => e
        @control_exception = e
      end
    end
    
    def variable(&proc)
      begin
        proc.call
      rescue Exception => e
        @variable_exception = e
      end      
    end
    
  end
end

