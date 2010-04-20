
installer 'haskell platform installed', :on => :osx do
  source "http://hackage.haskell.org/platform/2010.1.0.0/haskell-platform-2010.1.0.1-i386.dmg"

  met? {
    (`ghc --version`.include? "6.12.1") && (`cabal --version`.include? "0.8.0")
  } 
end

dep "kit" do
  requires "haskell platform installed"

  meet {
    log_shell "Checking that cabal is up to date", "cabal update && cabal install json mtl"
    git "git://github.com/nkpart/kit" do |path|
      Dir.chdir path do
        log_shell "Building", "cabal install"
      end
    end
  }
  
  met? do
    not shell("which kit").strip.empty?
  end
end

dep "mogeneration kit" do
  requires "kit", "mogeneration kit repository up to date"
end

dep "mogeneration kit repository cloned" do
  met? do
    result = log_shell("Checking for the mogeneration remote", "git remote show origin | grep Fetch")
    result && result.include?("git@github.com:mogeneration/kit-repository.git")
  end
  
  meet do
    log_shell "Cloning the mogeneration kit repository", "git clone git@github.com:mogeneration/kit-repository.git ~/.kit"
  end
end

dep "mogeneration kit repository up to date" do
  requires "mogeneration kit repository cloned"
  has_run = false
  met? do 
    has_run
  end
  meet do
    Dir.chdir(File.expand_path("~/.kit")) do
      log_shell "Updating the kit repository", "git pull"
    end
    has_run = true
  end
end