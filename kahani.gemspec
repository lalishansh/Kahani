# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "kahani"
  spec.version       = "0.1.0"
  spec.authors       = ["Ishansh Lal"]
  spec.email         = ["lalishansh@gmail.com"]

  spec.summary       = "#TODO: Write a short summary, because Rubygems requires one."
  spec.homepage      = "https://lalishansh.github.io"
  spec.license       = "MIT"

  # Added _plugins, 404.html, index.html, _config.yml to the list of files
  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|lib|_data|_layouts|_includes|_sass|_plugins|index\.html|404\.html|_config\.yml|README\.md|LICENSE)!i) }

  spec.add_runtime_dependency "jekyll", "~> 4.3"
  
  spec.add_development_dependency "jekyll-relative-links", "~> 0.7.0"
  spec.add_development_dependency "jekyll-toc", "~> 0.5"
end
