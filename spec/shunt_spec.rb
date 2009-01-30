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
    
    it "should result in a failure if only the control block passes" do
      pending
    end
    
    it "should result in a failure if only the variable block passes" do
      pending
    end
    
    it "should result in a failure if variable fails in a different way than control" do
      pending
    end
    
    it "should result in a pending spec if variable fails in exactly the same way as control" do
      pending
    end
  end
  
end
