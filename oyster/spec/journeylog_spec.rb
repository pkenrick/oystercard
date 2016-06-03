require 'journeylog'

  describe JourneyLog do

    let(:journey) {double :journey}
    let(:entry_station) {double :entry_station}
    let(:journey_class) {double :journey_class, new: journey}

    subject(:journeylog) {described_class.new(journey_class)} 

    it 'has an empty array for storage' do
      expect(journeylog.journeys).to eq []
    end

    describe '#start' do

      it 'starts a new journey with the entry station provided' do
        allow(journey).to receive(:entry_station) {entry_station} 
        allow(entry_station).to receive(:name) {"Bank"}
        journey1 = journeylog.start("Bank", journey)
        name1 = journey1.entry_station.name
        expect(name1).to eq "Bank"
      end

    end


  end