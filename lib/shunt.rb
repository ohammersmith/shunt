$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Shunt
  VERSION = '0.0.1'
  
  
  def raise_an_error
    raise "blah blah"
  end

  def go(&proc)
    @shunt = Shunt.new
    yield @shunt
    @shunt.validate!
  end
  
  class Shunt  # TODO should this be the self construct?
    
    def initialize
      
    end
    
    def validate!
      if control_exception.nil? && variable_exception.nil?
        raise Spec::Expectations::ExpectationNotMetError.new("The code isn't broken, please break something.")
      elsif control_exception.nil? && !variable_exception.nil?
        raise Spec::Expectations::ExpectationNotMetError.new("The control spec passes, is the code under test broken?")
      elsif !control_exception.nil? && variable_exception.nil?
        raise Spec::Expectations::ExpectationNotMetError.new("The variable spec passes now.")
      elsif !control_exception.message.eql?(variable_exception.message)
        raise Spec::Expectations::ExpectationNotMetError.new("The control and variable specs fail in different ways") 
      else
        raise Spec::Example::ExamplePendingError.new("Shunt in progress")
      end
    end
    
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

