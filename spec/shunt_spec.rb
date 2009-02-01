require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Shunt" do

  describe "#go" do
    
    it "should result in a failure if both blocks pass" do
      lambda do
        
        Shunt.go do |shunt|
          shunt.control { true.should be_true }
          shunt.variable { true.should be_true }
        end
        
      end.should raise_error(Spec::Expectations::ExpectationNotMetError, "The code isn't broken, please break something.") 
    end
    
    it "should result in a failure if only the control block fails" do
      lambda do
        
        Shunt.go do |shunt|
          shunt.control { true.should be_false }
          shunt.variable { true.should be_true }
        end
        
      end.should raise_error(Spec::Expectations::ExpectationNotMetError, "The variable spec passes now.") 
    end
    
    it "should result in a failure if only the variable block fails" do
      lambda do
        
        Shunt.go do |shunt|
          shunt.control { true.should be_true }
          shunt.variable { true.should be_false }
        end
        
      end.should raise_error(Spec::Expectations::ExpectationNotMetError, "The control spec passes, is the code under test broken?")
    end
    
    it "should result in a failure if variable fails in a different way than control" do
      lambda do
        
        Shunt.go do |shunt|
          shunt.control { true.should be_false }
          shunt.variable { false.should be_true }
        end
        # TODO it should probaly give some stack traces of the originals somehow
        
      end.should raise_error(Spec::Expectations::ExpectationNotMetError, "The control and variable specs fail in different ways")
    end
    
    it "should result in a pending spec if variable fails in exactly the same way as control" do
      lambda do
        Shunt.go do |shunt|
          shunt.control { true.should be_false }
          shunt.variable { true.should be_false }
        end
        
      end.should raise_error(Spec::Example::ExamplePendingError, "Shunt in progress")
      
    end
    
    xit "should result in a failure if variable fails with the same message as control, but a different stack trace" do
      pending "I'm not sure this is possible, since I would have filter out parts of the stack trace that are in the spec itself, plus any other places that are allowed to change."
    end

  end  
  
  describe "shunt across scopes" do
    it "should be maaagic"
  end
end
