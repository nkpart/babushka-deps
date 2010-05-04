meta :dl do
  accepts_list_for :source
end

dl "Consolas" do
  met? {
    "/Library/Fonts/Consolas.ttf".p.exists?
  }
  
  source "http://download.microsoft.com/download/8/E/7/8E7B9BB9-62EB-40E9-A135-D6AB5A991851/OpenXMLConverter102.dmg"
  
  before {
    puts "ok"
    process_sources {
      puts "process"
      log_shell "Installing fonts...", "installer -target / -pkg \"Open XML File Format Converter for Mac 1.0.2.mpkg/Contents/Packages/OpenXML_all_fonts.pkg\""
    }
    puts "wat"
  }
end