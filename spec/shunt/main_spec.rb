require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Shunter, "a whole other way of doing it" do
  
end

describe Shunter do
  
  before(:each) do
    @shunt = Shunter.new
    @pending_example = lambda { pending "yes I pended" }
    @failing_example = lambda { violated "yes I failed" }
    @failing_example_again = Spec::Expectations::ExpectationNotMetError
    @failing_example_alt = lambda { violated "I'm failing in an entirely different way" }
    @passing_example = lambda { true.should be_true }
  end

  xit "pending example should be pending" do
    @pending_example.should raise_error(Spec::Example::ExamplePendingError)
  end

  xit "failing example should be failing" do
    @failing_example.should raise_error(Spec::Expectations::ExpectationNotMetError)
  end
  
  xit "passing example should be passing" do
    @passing_example.should_not raise_error
  end
  
  xit "should fail if both the control and the variable proc passes" do
    @shunt.control  @passing_example
    @shunt.variable  @passing_example
    lambda { @shunt.trial }.should raise_error(Spec::Expectations::ExpectationNotMetError)
  end
  
  xit "should fail if only the variable proc passes" do
    @shunt.control  @failing_example
    @shunt.variable  @passing_example
    lambda { @shunt.trial }.should raise_error(Spec::Expectations::ExpectationNotMetError)
  end

  xit "should fail if only the control proc passes" do
    @shunt.control @passing_example
    @shunt.variable  @failing_example
    lambda { @shunt.trial }.should raise_error(Spec::Expectations::ExpectationNotMetError)
  end
  
  
  xit "should be pending if the trial proc fails in the same way as the control proc" do
    @shunt.control  @failing_example
    @shunt.variable  @failing_example_again
    lambda { @shunt.trial }.should raise_error(Spec::Example::ExamplePendingError)
  end
  
  xit "should set the pending message to ... i don't know what but something other than the default" do
    pending
  end
  
  # maybe it should look something like this:
  
  # Shunt.trial do |shunt|
  #   shunt.control { original_code }
  #   shunt.trial { new_code }
  # end
  
  
  # TODO figure out if I should have a singleton class or whatever like factory_girl... really I probably
  # want one, it wouldn't do to have multiple instances of a shunt not failing the right stuff 
  # almost certainly... 'cuz I don't like the interface that's happening here.
  
  # it "scartch for figuring out the types of errrors" do
  #   # lambda { true.should be_false }.should_not raise_error  # Spec::Expectations::ExpectationNotMetError, natch
  #   
  #   
  #   # lambda { lambda { puts "umm" }.should change do
  #   #   puts " hi there "
  #   # end }.should_not raise_error
  #   # this it what it takes to get Spec::Matchers::MatcherError
  #   # now.  what the fuck is should doing taking a block?  oh jeez.  I can eval that to a nmmber.  passing a symbol is just
  #   # convenience.  in fact mothafucker it acutally is a block 'cuz Symbol#to_proc exists  wow.
  # end
  
  
  # list of what I think are legit Spec failure exceptions
  # class ExamplePendingError < StandardError
  # class NotYetImplementedError < ExamplePendingError  # i think this is the type that's thrown when there's no block passed to it, but I can't confirm without spending a lot of time reading the rspec code
  # class ExpectationNotMetError < superclass   superclass is either Test::Unit::AssertionFailedError or StandardError depending
  # on whether Test::Unit is available... fuckin' clever code to do it, too.
  # class InvalidMatcherError < ArgumentError; end      # dosn't seem to ever be raised
  # class MatcherError < StandardError; end
  # now that I have all of them it occurs to me that I really ought to be just looking at how rspec accumulates it's counts  derr derr
  #
  
end
