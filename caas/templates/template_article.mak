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

<div class="container">
    <div class="row">
	<div class="col-md-8 col-md-offset-2" align='justify'>
	% if article:
	  <p>
	    <a href="${request.route_url('edit', pub='article', id=article.id)}">Edit</a>
	    <a href="${request.route_url('remove', pub='article', id=article.id)}">Remove</a>
	  </p>
	    ${article.maintext|n}
	% else:
	  There's no such article
	% endif  	
        </div>
    </div>
</div>


