module IoHelper
  def stub_nonfunctional_output
    allow(STDOUT).to receive(:print)
    expect(STDOUT).to receive(:puts).with('type ? for help').ordered
  end

  def expect_grid_output(rows)
    rows.each do |row|
      expect(STDOUT).to receive(:puts).with(row).ordered
    end
  end
end
