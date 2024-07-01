# # in _config.yml
# dir_to_yaml:
#   enabled: true
#   mappings:
#     - collection: posts # mandatory
#       yaml: _data/posts-dir.yaml # mandatory
#       include: # optional, default is [ "*" ]
#         - "*.md"
#         - "*.html"
#       exclude: # optional, default is []
#         - "index.*"
#     - ... # more mappings

# # TODO: support for sub-folder level index.(html, md) for folder pages
# # in _data/posts-dir.yaml (and other generated files)
# - name: Folder 1
#   children:
#   - name: File 1.md
#     href: /posts/folder-1/file-1/
#   - name: File 2.md
#     href: /posts/folder-1/file-2/
#   - name: Folder 2
#     children:
#     - name: File 3.md
#       href: /posts/folder-1/folder-2/file-3/
#     - name: Folder 3
#       children:
#       - name: File 4.md
#         href: /posts/folder-1/folder-2/folder-3/file-4/
#       - name: File 5.md
#         href: /posts/folder-1/folder-2/folder-3/file-5/
#   - name: Folder 4
#     children:
#     - name: File 6.md
#       href: /posts/folder-1/folder-4/file-6/
# - name: Folder 5
#   children:
#   - name: File 7.md
#     href: /posts/folder-5/file-7/  
#   - name: File 8.md
#     href: /posts/folder-5/file-8/
#   - name: File 9.md
#     href: /posts/folder-5/file-9/

module Reading
    class DirStuctNavPageGenerator < Jekyll::Generator
        safe true
        attr_accessor :site, :config

        KEY_CONFIG = "dir_to_yaml"

        def context
            @context ||= JekyllRelativeLinks::Context.new(site)
        end

        def generate(site)
            @site = site
            @config = @site.config[KEY_CONFIG]
            @potential_targets ||= @site.pages + @site.static_files + @site.docs_to_write

            return if @config.nil? || !@config["enabled"]

            @config["mappings"].each do |mapping|
                generate_data_file(mapping)
            end
        end

        def generate_data_file(mapping)
            collection = mapping["collection"]
            yaml = mapping["yaml"]

            include_filter = mapping["include"] || ["*"]
            exclude_filter = mapping["exclude"] || []

            root = @site.collections[collection].directory

            tree_obj = create_nav_tree(root, include_filter, exclude_filter)

            File.open(yaml, "w") do |f|
                f.write(tree_obj['children'].to_yaml)
            end

            # obj = []
            # @potential_targets.each do |target|
            #     obj << {
            #         "url" => target.url,
            #         "path" => target.relative_path
            #     }
            # end
            # File.open("_data/all_potential_targets.yaml", "w") do |f|
            #     f.write(obj.to_yaml)
            # end
        end

        def create_nav_tree(path, include_files = ['*'], exclude_files = [])
            this_path = Pathname.new(path).realpath
            root_path = this_path.parent.realpath

            create_nav_tree_impl(this_path, root_path, include_files, exclude_files)
        end

        def create_tree_entry(name, children, path, root)
            entry = {}
            
            entry['name'] = name

            if ! children.empty?
                entry['children'] = children
            end

            if ! path.directory?
                path_from_root = path.relative_path_from(root).to_s
                target = @potential_targets.find { |p| p.relative_path.sub(%r!\A/!, "") == path_from_root }
                entry['href'] = target.url
            end



            return entry
        end

        def create_nav_tree_impl(path, root, include_files = ['*'], exclude_files = [])
            # NOTE: path, root are of type 'Pathname'
            name = path.basename.to_s
            children = []
            if File.directory?(path)
                # iterate over all files and directories, and create a tree entry for each
                Dir.foreach(path) do |entry|
                    next if entry == '.' || entry == '..'

                    child_path = path.join(entry)
                    next unless child_path.directory? || filter_files(entry, include_files, exclude_files)

                    subtree = create_nav_tree_impl(child_path, root, include_files, exclude_files)
                    next if subtree.nil?

                    children << subtree
                end

                # return nil if there are no (valid) children
                return nil if children.empty?

                # TODO: use path += 'index.html' when it exists and is filtered
            end

            return create_tree_entry(name, children, path, root)
        end

        def filter_files(entry, includes, excludes)
            pass = false

            includes.each do |include_file|
                if File.fnmatch?(include_file, entry)
                    pass = true
                    break
                end
            end

            excludes.each do |exclude_file|
                if File.fnmatch?(exclude_file, entry)
                    pass = false
                    break
                end
            end

            return pass
        end
    end
end