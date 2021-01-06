require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Turtle do
  TASK = "buy milk"
  Turtle::Path[:root] = '._turtle'
  Turtle::Path[:db] = '._turtle/database.yml'
  Turtle::Path[:paths] = '._turtle/paths'

  context "in a new project" do
    before(:each) do
      FileUtils.rm_rf(Turtle::Path[:root])
      FileUtils.rm_rf(File.join(ENV['HOME'], Turtle::Path[:root]))
    end

    it "should initialize the .turtle directory" do
      Turtle.run(:init)
      File.exist?(Turtle::Path[:root]).should == true
      File.exist?(Turtle::Path[:db]).should == true
    end

    it "should create a .turtle in ~" do
      Turtle.run(:init)
      File.exist?(File.join(ENV['HOME'], Turtle::Path[:root])).
        should == true
      File.read(File.join(ENV['HOME'], Turtle::Path[:paths])).
        split(/\n/).should include(File.expand_path(Dir.pwd))
    end

    it "should warn that the project isn't initialized" do
      -> {Turtle.run(:list)}.should raise_error(SystemExit)
    end
  end

  context "in an existing project" do
    before(:all) do
      Turtle.init!
    end

    context "with no tasks" do
      it "shouldn't try to init" do
        -> {Turtle.run(:init)}.should raise_error(SystemExit)
      end

      it "should warn about invalid commands" do
        -> {Turtle.run(:choo)}.should raise_error(SystemExit)
      end

      it "should add tasks" do
        if Turtle.run(:add, TASK)
          e = Turtle::Database.new(Turtle::Path[:db]).find(TASK)
          e.should be_a(Turtle::Entity)
          e[:status].should == :created
          e[:tags].should == []
        else
          fail
        end
      end
    end

    context "with a couple tasks" do
      TASKS = ["milk", "eggs", "bananas"]
      before(:each) do
        Turtle.init!
        TASKS.each do |t|
          Turtle.run(:add, t)
        end
        @db = Turtle::Database.new(Turtle::Path[:db])
      end

      it "should remove tasks" do
        Turtle.run(:remove, TASKS.last)
        @db.load.find(TASKS.last)[:status].should == :removed
      end

      it "should complete tasks" do
        Turtle.run(:did, TASKS.first)
        @db.load.find(TASKS.first)[:status].should == :completed
      end

      it "should tag tasks" do
        Turtle.run(:tag, TASKS[1], "food")
        @db.load.find(TASKS[1])[:tags].should include("food")
      end

      it "should rise tasks" do
        Turtle.run(:rise, TASKS[2])
        @db.load[1][:title].should == TASKS[2]
      end

      it "should sink tasks" do
        Turtle.run(:sink, TASKS[1])
        @db.load.last[:title].should == TASKS[1]
      end

      it "should show tasks with specific tags" do
        Turtle.run(:tag, TASKS[1], "#food")
        Turtle.run(:show, ["#food"]).first[:title].should == TASKS[1]
      end

      it "should sticky tasks" do
        Turtle.run(:float, TASKS[2])
        @db.load.list[0][:title].should == TASKS[2]
        @db.load.find(TASKS[2])[:sticky].should be_true
      end

      it "should warn when the task wasn't found" do
        -> {Turtle.run(:did, "celery")}.should raise_error(SystemExit)
      end
    end
  end

  after(:all) do
    FileUtils.rm_rf(Turtle::Path[:root])
    FileUtils.rm_rf(File.join(ENV['HOME'], Turtle::Path[:root]))
  end
end

