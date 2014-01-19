require "minitest/autorun"

class Team

  def initialize(*players)
    @roster = Array.new
    @roster.push(players).flatten!
  end

  # contrived and highly coupled example merely to demonstrate stacked addition of arrays, sorry.
  def add_players(draft_picks, offseason_signings)
    new_guys = draft_picks + offseason_signings  # merge the contents of the arrays. for demo purposes only, won't use 'new_guys' so we can show the following:
    @roster << draft_picks.flatten << offseason_signings.flatten # add these players to the end of the team; you can layer these as shown.
  end

  def cut_players(cuts)
   @roster = @roster - cuts.flatten  # subtract the contents of the right array that are common with the left array.
  end

  def << player
    @roster.push(player)  # example of a bespoke unary operator added for convenience and expression.
  end

  def size
    @roster.flatten.size
  end

  def rookies
    @roster.select do |player| 
      player == "Griffin" || player == "Cousins"
    end
  end

  def salary
    [200000, 440000, 800000, 12100000].inject(0) do |result, item|
      item + result
    end
  end

  def to_s
    puts "The team is " + @roster.join(" ")
  end
end

describe Team do
  
  describe "player features" do 

    before do
      @team = Team.new("Griffin", "Cousins", "Moss", "Garcon")
    end

    it "initializes roster correctly" do
      @team.size.must_equal 4
    end

    it "can add players" do
      draft_picks = ["Rambo", "Amerson", "Reed"]
      off_season_adds = ["Biggers", "Tapp"]
      @team.add_players(draft_picks, off_season_adds)
      @team.size.must_equal(9)
    end

    it "can cut players" do
      @team << "Compton" << "Trueblood"
      @team.size.must_equal(6)
      cuts = ["Compton", "Trueblood"]
      @team.cut_players(cuts)
      @team.size.must_equal(4)
    end
  end

  describe "roster meta-data features" do

    before do
      @team = Team.new("Griffin", "Cousins", "Moss", "Garcon")
    end

    it "can size roster" do
      #puts @team
      @team.size.must_equal(4)
    end

    it "can get rookies" do
      @team.rookies.join.must_equal("GriffinCousins")
      #puts @team.rookies.join
    end

    it "can get salaries" do
      @team.salary.must_equal 13540000
    end
  end
end

