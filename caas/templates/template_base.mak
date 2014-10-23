<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" xmlns:tal="http://xml.zope.org/namespaces/tal">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="keywords" content="caas discuss page" />
    <meta name="description" content="caas" />
    <title>¡CAAS!</title>
    
    <link rel="stylesheet" href="${req.static_url('caas:static/css/main.css')}" type="text/css" />
    <link rel="stylesheet" href="${req.static_url('caas:static/css/bootstrap.css')}" type="text/css" />
    <link rel="stylesheet" href="${req.static_url('caas:static/css/colorbox.css')}" type="text/css" />
    <link rel="stylesheet" href="${req.static_url('caas:static/css/bootstrap-glyphicons.css')}" type="text/css" />
    ## get the local copies
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
    
    <script type="text/javascript" src="${req.static_url('caas:static/js/jquery.js')}"></script>
    <script type="text/javascript" src="${req.static_url('caas:static/js/jquery.actual.js')}"></script>
    <script type="text/javascript" src="${req.static_url('caas:static/js/bootstrap.js')}"></script>
    <script type="text/javascript" src="${req.static_url('caas:static/js/jquery.photoset-grid.js')}"></script>
    <script type="text/javascript" src="${req.static_url('caas:static/js/jquery.colorbox.js')}"></script>
    
    <script type="text/javascript">
     $(window).load( function() {
       $('.photoset-grid-lightbox').photosetGrid({
	 highresLinks: true,
	 lowresWidth: 400,
	 rel: 'withhearts-gallery',
	 gutter: '2px',
	 lowresWidth:100,
	 onComplete: function(){
	   $('.photoset-grid-lightbox').attr('style', '');
	   $('.photoset-grid-lightbox a').colorbox({
	     photo: true,
	     scalePhotos: true,
	     minWidth:'1%',
	     maxHeight:'90%',
	     maxWidth:'90%'
	   });
	 }
       });
     });
    </script>
    
  </head>
  <body id="yellowfonts">
    
    ## set navbar here

  <div class="container">
    
    <nav class="navbar navbar-default navbar-static-top" role="navigation">
      <a class="navbar-brand">${pagename}</a>
      <div class="container">
	<p class="navbar-text navbar-right">
	  % if auth:
	    Шалом, ${authuser}! 
	    <a data-toggle="tooltip" data-placement="top" title="Выйти" href="${request.route_url('logout')}"><span class="glyphicon glyphicon-circle-arrow-right"></span></a>
	  % else:
	    % if request.current_route_url() != request.route_url('login'):
	      <a href="${request.route_url('login')}">Вход</a>
	    % endif  
	  % endif
	  <ul class="nav navbar-nav">
            ##
	    % if request.current_route_url() != request.route_url('main'):
	      <li><a href="${request.route_url('main')}">Главная</a></li>
	    % endif
	    % if auth:
	      % if not 'discuss' in request.current_route_url():
		<li><a href="${request.route_url('home')}">Глагне</a></li>
	      % else:
		## put a link here
		<li><a href="#"> новые комментарии <span class="badge">${str(newcommentscount)}</span></a></li>
	      % endif
	      % if request.current_route_url() != request.route_url('newarticle'):
		<li><a href="${request.route_url('newarticle')}">Новая статья</a></li>
	      % endif
	    % endif
	  </ul>
	</p>
      </div>
    </nav>
    
    ${next.body()}
  </body>
</html>
