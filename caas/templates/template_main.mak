## -*- coding: utf-8 -*-

<%inherit file="caas:templates/template_base.mak"/>

<script type="text/javascript">
$(window).load( function() {
$('.photoset-grid-lightbox').photosetGrid({
  highresLinks: true,
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

% if auth:
  <a href="${request.route_url('logout')}">Logout</a>
  <a href="${request.route_url('home')}">Discuss</a>
% else:
  <a href="${request.route_url('login')}">Login</a>
% endif

<p class="text-justify bg-info">
  ${message}
</p>

<div class="container">
  <div class="row">
    <div class="col-md-8 col-md-offset-2" align='justify'>
      % if articles:
	% for a in articles:
	  ##  ${a.maintext|n}
	  <p> <a href="${request.route_url('article', url=a.url)}">${a.mainname}</a> </p>
	% endfor  
      % else:
	There's no articles yet. 
      % endif  	
    </div>
  </div>
</div>
   

