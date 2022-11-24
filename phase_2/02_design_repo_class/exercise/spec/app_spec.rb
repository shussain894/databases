require_relative '../app'

RSpec.describe Application do
  it "lists all the albums when prompted" do
    terminal = double :terminal
    expect(terminal).to receive(:puts).with('Welcome to the music library manager!').ordered
    expect(terminal).to receive(:puts).with('What would you like to do?').ordered
    expect(terminal).to receive(:puts).with('1 - List all albums').ordered
    expect(terminal).to receive(:puts).with('2 - List all artists').ordered
    expect(terminal).to receive(:puts).with("Enter your choice:").ordered
    expect(terminal).to receive(:gets).and_return('1').ordered
    expect(terminal).to receive(:puts).with("Here is the list of albums:").ordered
    expect(terminal).to receive(:puts).with('* 1 - Doolittle').ordered
    expect(terminal).to receive(:puts).with('* 2 - Surfer Rosa').ordered
    expect(terminal).to receive(:puts).with('* 3 - Waterloo').ordered
    expect(terminal).to receive(:puts).with('* 4 - Super Trouper').ordered
    expect(terminal).to receive(:puts).with('* 5 - Bossanova').ordered
    expect(terminal).to receive(:puts).with('* 6 - Lover').ordered
    expect(terminal).to receive(:puts).with('* 7 - Folklore').ordered
    expect(terminal).to receive(:puts).with('* 8 - I Put a Spell on You').ordered
    expect(terminal).to receive(:puts).with('* 9 - Baltimore').ordered
    expect(terminal).to receive(:puts).with("* 10 - Here Comes the Sun").ordered
    expect(terminal).to receive(:puts).with("* 11 - Fodder on My Wings").ordered
    expect(terminal).to receive(:puts).with("* 12 - Ring Ring").ordered

    album_repository = AlbumRepository.new
    app = Application.new('music_library', terminal, album_repository)
    app.run
  end
end 

