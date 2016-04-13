module IoHelper
  def stub_nonfunctional_output
    allow(STDOUT).to receive(:print)
    expect(STDOUT).to receive(:puts).with('type ? for help').ordered
  end
end
