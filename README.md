# Apache `mod_autoindex` CSS

## Building

Run `make` to generate `autoindex.css`.

Build requirements:

- `nodejs`
- `pnpm`
- `sassc`

## Installation

Compile the css and then install it as `/var/www/apache-css/autoindex.css`.

Then, update your Apache configuration:

```apache
IndexOptions \
    Charset=UTF-8 \
    DescriptionWidth=* \
    FancyIndexing \
    FoldersFirst \
    HTMLTable \
    IconsAreLinks \
    NameWidth=* \
    VersionSort \
    XHTML \

# Re-route incoming requests to this folder
Alias /apache-css "/var/www/apache-css"

<Directory "/var/www/apache-css">
    # Required - allow requests
    Require all granted
    # Optional - allow indexing the folder
    Options Indexes
    # Optional - only if you're keeping a git clone in the folder
    AllowOverride all
</Directory>

# Make the responsive design aspects of the stylesheet work on mobile devices
IndexHeadInsert '\
    <meta name="viewport" content="width=device-width, initial-scale=1"/>\
'
IndexStyleSheet "/apache-css/autoindex.css"
```
