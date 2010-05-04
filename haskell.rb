installer 'haskell platform installed', :on => :osx do
  source "http://hackage.haskell.org/platform/2010.1.0.0/haskell-platform-2010.1.0.1-i386.dmg"

  met? {
    (`ghc --version`.include? "6.12.1") && (`cabal --version`.include? "0.8.0")
  } 
end

dep "yesod-0.2" do
  requires 'haskell platform installed'
  
  met? {
    system "cabal list --installed --simple-output | grep \"yesod 0.2.0\""
  }
  
  meet {
    log_shell("Updating cabal", "cabal update")
    git "git://github.com/snoyberg/yesod.git" do |path|
      log_shell("Switching to release branch", "git checkout origin/ver0.2")
      log_shell("Running install", "cabal install")
    end
  }
end