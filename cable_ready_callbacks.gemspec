require_relative "lib/cable_ready_callbacks/version"

Gem::Specification.new do |spec|
  spec.name = "cable_ready_callbacks"
  spec.version = CableReadyCallbacks::VERSION
  spec.authors = ["Julian Rubisch"]
  spec.email = ["julian@julianrubisch.at"]
  spec.homepage = "https://github.com/julianrubisch/cable_ready_callbacks"
  spec.summary = "Broadcast to your resources effortlessly"
  spec.description = "Broadcast to your resources effortlessly"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/julianrubisch/cable_ready_callbacks"
  spec.metadata["changelog_uri"] = "https://github.com/julianrubisch/cable_ready_callbacks/blob/main/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 6.0.0", "< 7"
  spec.add_dependency "cable_ready", ">= 4.4.0"

  spec.add_development_dependency "standard"
end
