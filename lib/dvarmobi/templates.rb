class Templates
  def self.container
    return <<-EOF
<?xml version="1.0" encoding="UTF-8" ?>
<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
  <rootfiles>
    <rootfile full-path="OEBPS/content.opf" media-type="application/oebps-package+xml"/>
  </rootfiles>
</container>
EOF
  end
  def self.content
    return <<-EOF
<?xml version="1.0" encoding="UTF-8"??>
<package xmlns="http://www.idpf.org/2007/opf" unique-identifier="BookID" version="2.0" >
    <metadata xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:opf="http://www.idpf.org/2007/opf">
        <dc:title>Dvarmobi</dc:title> 
        <dc:creator opf:role="aut">Tom Burger</dc:creator>
        <dc:language>en-US</dc:language> 
        <dc:rights>Public Domain</dc:rights> 
        <dc:publisher>burger.cz</dc:publisher> 
        <dc:identifier id="BookID" opf:scheme="UUID">tomburger-dvarmobi-sample</dc:identifier>
    </metadata>
    <manifest>
        <item id="ncx" href="toc.ncx" media-type="application/x-dtbncx+xml" />
        <item id="style" href="styles.css" media-type="text/css" />
        <%= manifest %>
    </manifest>
    <spine toc="ncx">
        <%= spine %>
    </spine>
</package>
EOF
  end
  def self.manifest
    return "<item id='<%= page %>' href='<%= page %>.xhtml' media-type='application/xhtml+xml' />"
  end
  def self.spine
    return "<itemref idref='<%= page %>' />"
  end
  def self.toc
    return <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1">

<head>
    <meta name="dtb:uid" content="tomburger-dvarmobi-sample"/>
    <meta name="dtb:depth" content="1"/>
    <meta name="dtb:totalPageCount" content="0"/>
    <meta name="dtb:maxPageNumber" content="0"/>
</head>

<docTitle>
    <text>Dvarmobi</text>
</docTitle>

<navMap>
  <%= navpoints %>
</navMap>
</ncx>
    EOF
  end
  def self.navpoint
    return <<-EOF
<navPoint id="<%= id %>" playOrder="<%= index %>">
    <navLabel>
        <text><%= title %></text>
    </navLabel>
    <content src="<%= id %>.xhtml"/>
</navPoint>
    EOF
  end
  def self.styles
    return <<-EOF
h1 { font-size: 1.2em; }
EOF
  end
  def self.chapter
    return <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><%= title %></title>
    <link rel="stylesheet" type="text/css" href="styles.css"></link>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  </head>
  <body>
    <h1><%= title %></h1>
    <hr/>
    <%= content %>
  </body>
</html>
EOF
  end
end
