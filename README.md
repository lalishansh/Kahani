# kahani

Welcome to your new Jekyll theme! In this directory, you'll find the files you need to be able to package up your theme into a gem. Put your layouts in `_layouts`, your includes in `_includes`, your sass files in `_sass` and any other assets in `assets`.

To experiment with this code, add some sample content and run `bundle exec jekyll serve` – this directory is setup just like a Jekyll site!

TODO: Delete this and the text above, and describe your gem

## Installation

**NOTE(s)**: 
- branch `test` is for testing with newly created jekyll gem theme (ref [Creating a gem based theme](https://jekyllrb.com/docs/themes/#creating-a-gem-based-theme) & [kahani-demosite test branch](https://github.com/lalishansh/kahani-demosite/tree/test))
- Below instructions are for **super minimal** theme setup, see [Kahani Demosite](https://github.com/lalishansh/kahani-demosite) for more detailed setup.

Add these lines to file(s) in your Jekyll site's `ROOT`:

- `/Gemfile`:
    ```ruby
    gem "jekyll-remote-theme"
    ```

- `/_config.yml`:
    ```yaml
    remote_theme: lalishansh/kahani
    plugins:
    - jekyll-remote-theme
    ```

- `ROOT/index.html`:    
    ```html
    ---
    layout: home
    ---

    My site's root page.
    ```

- optionally `/_layouts/home.html` (demonstration of layout override):
    ```html
    ---
    layout: default
    ---

    layout inherited from _layouts/home.html inside consumer <br>

    {{ content }}
    ```

And then execute (from your Jekyll site's root directory):

    $ bundle

Or install gem yourself as:

    $ gem install jekyll-remote-theme

## Usage

Test with:

    $ bundle exec jekyll serve --livereload

TODO: Write usage instructions here. Describe your available layouts, includes, sass and/or assets.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kahani. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org/) code of conduct.

## Development

To set up your environment to develop this theme, run `bundle install`.

Your theme is setup just like a normal Jekyll site! To test your theme, run `bundle exec jekyll serve` and open your browser at `http://localhost:4000`. This starts a Jekyll server using your theme. Add pages, documents, data, etc. like normal to test your theme's contents. As you make modifications to your theme and to your content, your site will regenerate and you should see the changes in the browser after a refresh, just like normal.

When your theme is released, only the files in `_layouts`, `_includes`, `_sass` and `assets` tracked with Git will be bundled.
To add a custom directory to your theme-gem, please edit the regexp in `kahani.gemspec` accordingly.

## License

The theme is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
