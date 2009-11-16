$:.unshift "#{File.dirname(__FILE__)}/../lib"
require 'spec'

require 'planning_authority_results'

describe PlanningAuthorityResults do
  it "should hold multiple development applications" do
    da1 = DevelopmentApplication.new(:description => "A house being built")
    da2 = DevelopmentApplication.new(:description => "A house being knocked down")
    r = PlanningAuthorityResults.new
    r << da1
    r << da2
    r.applications.should == [da1, da2]
  end
  
  it "should have a short name and a regular name" do
    r = PlanningAuthorityResults.new(:name => "Blue Mountains City Council", :short_name => "Blue Mountains")
    r.name.should == "Blue Mountains City Council"
    r.short_name.should == "Blue Mountains"
  end
  
  it "should be serialisable to xml" do
    r = PlanningAuthorityResults.new(:name => "Blue Mountains City Council", :short_name => "Blue Mountains")
    da1 = mock("DevelopmentApplication")
    da2 = mock("DevelopmentApplication")
    da1.should_receive(:to_xml).and_return("    Some XML\n")
    da2.should_receive(:to_xml).and_return("    Some more XML\n")    
    r << da1
    r << da2
    r.to_xml.should == <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<planning>
  <authority_name>Blue Mountains City Council</authority_name>
  <authority_short_name>Blue Mountains</authority_short_name>
  <applications>
    Some XML
    Some more XML
  </applications>
</planning>
    EOF
  end
end

