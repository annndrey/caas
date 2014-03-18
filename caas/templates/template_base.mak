<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" xmlns:tal="http://xml.zope.org/namespaces/tal">
<head>
<meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="keywords" content="caas discuss page" />
        <meta name="description" content="caas" />
	<title>test-CAAS-test</title>

        <link rel="stylesheet" href="${req.static_url('caas:static/css/main.css')}" type="text/css" />
        <link rel="stylesheet" href="${req.static_url('caas:static/css/bootstrap.css')}" type="text/css" />
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">

	<script type="text/javascript" src="${req.static_url('caas:static/js/jquery.js')}"></script>
	<script type="text/javascript" src="${req.static_url('caas:static/js/jquery.actual.js')}"></script>
	<script type="text/javascript" src="${req.static_url('caas:static/js/bootstrap.js')}"></script>
	
</head>
<body>
${next.body()}
</body>
</html>
