$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Shunt
  VERSION = '0.0.1'
  
  
  def go(&proc)
    @shunt = Shunt.new
    yield @shunt
  end
  
  class Shunt  # TODO should this be the self construct, WTF is that anyway?
    def control(&proc)
      begin
        proc.call
      rescue Exception => e
        @control_exception = e
      end
      raise Spec::Expectations::ExpectationNotMetError.new("The code isn't broken, please break something.")
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

