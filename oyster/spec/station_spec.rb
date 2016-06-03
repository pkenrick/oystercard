require 'station'

describe Station do
  subject(:station) {described_class.new("Aldgate")}

it "has a name" do
  expect(station.name).to eq "Aldgate"
end

end