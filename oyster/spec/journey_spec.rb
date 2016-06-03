require 'journey'


describe Journey do

  subject(:journey) { described_class.new(station_name) }
  let(:station_name) {double :string}
  let(:station) {double :station}

  describe "upon initialization" do
    it "checks that entry station has been set" do
      expect(journey.entry_station).not_to eq nil
    end

    it "entry station responds to #zone (method of station class)" do
      expect(journey.entry_station).to respond_to(:zone)
    end
  end

  describe "#set_exit" do
    it "checks that an exit station has been set" do
      journey.set_exit(station_name)
      expect(journey.exit_station.name).to eq station_name
      end
    end


end