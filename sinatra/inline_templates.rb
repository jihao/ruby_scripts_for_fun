#!/usr/bin/env ruby
require "sinatra"

get '/index' do
  erb :index  # template name must be a symbol
end

__END__

@@index
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>Inline template</title>
</head>
<body>
<h1>Worked!</h1>
</body>
</html>