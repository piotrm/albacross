require 'rails_helper'

describe SeekEmployeeStats do
  let(:dept_no) { "d005" }

  subject { SeekEmployeeStats.new(dept_no) }

  describe ".call" do
    it "executes #call on a new instance of SeekEmployeeStats" do
      seek_stats_instance = double(:seek_stats_instance)
      allow(SeekEmployeeStats).to receive(:new).and_return(seek_stats_instance)

      expect(seek_stats_instance).to receive(:call)
      described_class.call(dept_no)
    end
  end

  describe "#call" do
    before do
      allow(subject).to receive(:fetch_stats).and_return(fetched_stats)
    end

    context "when search returns stats" do
      let(:fetched_stats) { double('fetched_stats', total: 10) }
      let(:formatted_stats) { double('formatted_stats') }

      before do      
        allow(subject).to receive(:format_stats).and_return(formatted_stats)
      end

      it "returns formatted stats" do
        expect(subject.call).to eq(formatted_stats)
      end
    end

    context "when search does not return stats" do
      let(:fetched_stats) { double('fetched_stats', total: 0) }

      it "returns formatted stats" do
        expect(subject.call).to eq([])
      end
    end
  end
end
