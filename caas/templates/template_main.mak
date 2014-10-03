## -*- coding: utf-8 -*-

<%inherit file="caas:templates/template_base.mak"/>


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
   

