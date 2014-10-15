## -*- coding: utf-8 -*-

<%inherit file="caas:templates/template_base.mak"/>

<div class="container">
  
  <div class="row">
    <div class="col-md-8 col-md-offset-2" align='justify'>
      % if articles:
	% for a in articles:
	  % if auth:
	    % if a.status == 'draft': 
	      <p> <a href="${request.route_url('article', url=a.url)}">${a.mainname}</a> <span class="label label-default"> ${statuses[a.status]}</span> [${a.user}]</p>
	    % endif  
	    % if a.status == 'private':
	      <p> <a href="${request.route_url('article', url=a.url)}">${a.mainname}</a> <span class="label label-warning"> ${statuses[a.status]}</span> [${a.user}]</p>
	    % endif
	  % endif 
	  % if a.status == "ready":
	    ##  ${a.maintext|n}
	    <p> <a href="${request.route_url('article', url=a.url)}">${a.mainname}</a></p>
	  % endif
	  
	% endfor  
      % else:
	There's no articles yet. 
      % endif  	
    </div>
  </div>
</div>


