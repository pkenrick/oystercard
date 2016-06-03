require 'journeylog'

  describe JourneyLog do

    let(:journey) {double :journey}
    let(:station) {double :station}
    let(:journey_class) {double :journey_class, new: journey}

    subject(:journeylog) {described_class.new(journey_class)} 

    it 'has an empty array for storage' do
      expect(journeylog.journeys).to eq []
    end


    describe '#start' do



      it 'starts a new journey with the entry station provided' do
        journeylog.start("Bank")
        allow(journey).to receive(:entry_station){station}
        allow(station).to receive(:name){"Bank"}
        expect(journeylog.journeys.last.entry_station.name).to eq("Bank")
      end

    end

    describe '#finish' do

      it 'ends a journey with the exit station provided' do
        journeylog.start("Bank")
        journeylog.finish("Aldgate")
        allow(journey).to receive(:exit_station){station}
        allow(station).to receive(:name){"Aldgate"}
        expect(journeylog.journeys.last.exit_station.name).to eq("Aldgate")
      end

    end


  end