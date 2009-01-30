module Shunt
  class Shunter

    def control(&control)
      @control = control ## can I do this?
    end


    def variable(&variable)
      @variable = variable
    end
    
    def trial
      # e1 = @control.call
      # e2 = @variable.call
      # don't think these are needed.
      # @e1 = nil
      # @e2 = nil
      
      # begin
      #   @control.call
      # rescue Exception => e1
      #   @e1 = e1
      # end
      # 
      # begin
      #   @variable.call
      # rescue Exception => e2
      #   @e2 = e2
      # end
      
      @e1 = capture_exception(&@control)
      @e2 = capture_exception(&@variable)
      
      raise Spec::Expectations::ExpectationNotMetError unless @e1 && @e2
      raise Spec::Example::ExamplePendingError
    end
    
    
    private

    def capture_exception(&proc)
      begin
        proc.call
      rescue Exception => e
        @e
      end
      return @e
    end

  end
end