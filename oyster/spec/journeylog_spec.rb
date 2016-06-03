require 'journeylog'

  describe JourneyLog do

    let(:journey) {double :journey}
    let(:entry_station) {double :entry_station}
    let(:journey_class) {double :journey_class, new: journey}

    subject(:journeylog) {described_class.new(journey_class: journey_class)} 

    describe "#start" do

      it 'starts a new journey using entry_station' do
        # journeylog.new
      end

    end


  end