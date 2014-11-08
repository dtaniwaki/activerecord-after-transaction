Gem::Specification.new do |gem|
  gem.name        = "activerecord-after-transaction"
  gem.version     = ::File.read(::File.expand_path('../VERSION', __FILE__)).to_s.strip
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ["Daisuke Taniwaki"]
  gem.email       = ["daisuketaniwaki@gmail.com"]
  gem.homepage    = "https://github.com/dtaniwaki/activerecord-after-transaction"
  gem.summary     = "Exec Proc After Transaction"
  gem.description = "Exec Proc After Transaction"
  gem.license     = "MIT"

  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency "activerecord", ">= 3.2"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", ">= 3.0"
end
