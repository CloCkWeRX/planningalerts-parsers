$:.unshift "#{File.dirname(__FILE__)}/../../lib"
require 'spec'
require 'date_with_non_american_bias'

describe Date do
  it "should parse regular dates in the normal way you would expect" do
    Date.parse("1 Feb 2009").should == Date.new(2009, 2, 1)
  end
  
  it "should parse an australian date correctly damn it!" do
    Date.parse("12/11/2009").should == Date.new(2009,11,12)
  end
end