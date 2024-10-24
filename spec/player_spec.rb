require_relative '../lib/player'

describe Player do
  subject { Player.new('Gurleen') }
  describe '#initialize' do
    it 'makes new instance with name attribute' do
      expect(subject.name).to eql('Gurleen')
    end
  end
end
