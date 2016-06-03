require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new(journeylog_class)}
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey) { double :journey}
  let(:journeylog_class) {double :journeylog_class, new: journeylog}
  let(:journeylog) {double :journeylog}
# In order to use public transport
# As a customer
# I want money on my card

  describe "responds to" do
    it { is_expected.to respond_to(:balance) }

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it { is_expected.to respond_to(:touch_out) }

    it { is_expected.to respond_to(:entry_station) }
  end

  describe '#balance' do
  	it 'has an initial balance of 0' do
  		expect(card.balance).to eq 0
	   end
  end

	describe "#top_up" do

		it "should increase the balance" do
			expect(card.top_up(5)).to be == card.balance
		end

		it 'raises an error if top_up amount would push balance over 90' do
			expect { card.top_up(91) }.to raise_error "Can't add to your balance; would breach the £90 limit"
		end
	end

  describe "#touch_in" do

    it "changes the card to be in_journey" do
      card.top_up(1)
      card.touch_in(entry_station)
      expect(card.in_journey?).to eq true
    end
    it "raises an error if the card does not have the minimum balance for a journey" do
      expect{card.touch_in(entry_station)}.to raise_error 'Insufficient funds for journey'
    end
  end

  describe "#touch_out" do
    before(:each) do
      card.top_up(1)
      card.touch_in(entry_station)
    end
    it "changes the card to not be in_journey" do
     card.touch_out(exit_station)
     expect(card).not_to be_in_journey
   end
   it "calls the #deduct method" do
     expect(card).to receive(:deduct)
     card.touch_out(exit_station)
   end

   it "should deduct 1 from the balance" do
     expect {card.touch_out(exit_station)}.to change{card.balance}.by(-1)
   end

   it "should forget the journey's entry station" do
     card.touch_out(exit_station)
     expect(card.entry_station).to eq nil
   end

  end

  describe "#in_journey?" do

    it "returns false if not in journey" do
      expect(card.in_journey?).to eq false
    end

    it "returns true if it is in journey" do
      card.top_up(1)
      card.touch_in(entry_station)
      expect(card.in_journey?).to eq true
    end
  end

  describe "#journeys" do
    it "shows all the trips that have been made with the card" do
      expect(card.journeys).to be_a Array
    end
    it "should start with no journeys" do
      expect(card.journeys).to eq []
    end
    it "contains the entry and exit station" do
      card.top_up(10)
      card.touch_in('station1')
      card.touch_out('station2')
      expect(card.journeys.last.entry_station.name).to eq 'station1'
      expect(card.journeys.last.exit_station.name).to eq 'station2'
    end

  end

  describe '#fare' do

    it 'should return the minimum fare' do
      allow(journey).to receive(:entry_station) {entry_station}
      allow(journey).to receive(:exit_station) {exit_station}
      allow(entry_station).to receive(:name) {entry_station}
      allow(exit_station).to receive(:name) {exit_station}
      expect(card.fare(journey)).to eq Oystercard::MINIMUM_FARE
    end

    it 'if journey missing entry or exit #fare should return penalty fare' do
      card.touch_out(exit_station)
      expect{card.touch_out(exit_station)}.to change{card.balance}.by(-Oystercard::PENALTY_FARE)
    end

  end

  describe "upon initialization" do

    it "creates a new instance of JourneyLog" do
      expect(card.journeylog).to eq(journeylog)
    end

  end


end
