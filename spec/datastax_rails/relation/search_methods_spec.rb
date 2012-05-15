require 'spec_helper'

describe DatastaxRails::Relation do
  before(:each) do
    @relation = DatastaxRails::Relation.new(Hobby, "hobbies")
  end
  
  describe "#limit" do
    it "should limit the page size" do
      "a".upto("l") do |letter|
        Hobby.create(:name => letter)
      end
      @relation.limit(7).all.size.should == 7
    end
  end
  
  describe "#page" do
    it "should get a particular page" do
      "a".upto("l") do |letter|
        Hobby.create(:name => letter)
      end
      @relation.per_page(3).page(2).order(:name).all.first.name.should == "d"
    end
  end
  
  describe "#group" do
    
  end
  
  describe "#order" do
    it "should return items in ascending order" do
      %w[fishing hiking boating jogging swimming chess].each do |word|
        Hobby.create(:name => word)
      end
      @relation.commit_solr
      @relation.order(:name).collect {|h| h.name}.should == %w[boating chess fishing hiking jogging swimming]
    end
    
    it "should return items in descending order" do
      %w[fishing hiking boating jogging swimming chess].each do |word|
        Hobby.create(:name => word)
      end
      @relation.commit_solr
      @relation.order(:name => :desc).collect {|h| h.name}.should == %w[swimming jogging hiking fishing chess boating]
    end
  end
  
  describe "#where" do
    
  end
  
  describe "#fulltext" do
    
  end
end