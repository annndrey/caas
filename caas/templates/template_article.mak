## -*- coding: utf-8 -*-

<%inherit file="caas:templates/template_base.mak"/>

  <div class="inner">
    <div class="row">
      <div class="col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2" align='justify'>
	% if article:
	  <p>
	    % if auth:
	      <a class="btn btn-default" href="${request.route_url('edit', pub='article', id=article.id)}">Править</a>
	      <a class="btn btn-default" data-toggle="modal" data-target=".modal-remove">Удалить</a>
	      <div class="modal fade modal-remove" tabindex="-1" role="dialog" aria-labelledby="modalRemoveLabel" aria-hidden="true">
		<div class="modal-dialog">
		  <div class="modal-content">
		    <div class="modal-header">
		      <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
		      <h4 class="modal-title" id="modalRemoveLabel">Удаление статьи</h4>
		    </div>
		    <div class="modal-body">
		      Вы действительно хотите удалить статью <strong>"${article.mainname}"</strong>?
		    </div>
		    <div class="modal-footer">
		      <button type="button" class="btn btn-default" data-dismiss="modal">Отмена</button>
		      <a href="${request.route_url('remove', pub='article', id=article.id)}" type="button" class="btn btn-primary">Удалить</a>
		    </div>
		  </div>
		</div>
	      </div>  
	      % endif 
	  </p>
${article.maintext|n}
	% else:
	  There's no such article
	% endif  	
	
	<hr class="style-thin">
	<div class="push1"></div>
	
	% if comments is not None:
	  % for p in comments:
	    <div class="row">
	      <div class="panel panel-default">
		<div class="panel-heading">
     		  <h4>${p.name}: <small>${p.date.strftime('%d/%m/%Y %H:%M')}</small></h4>
		</div>
		<div class="panel-body">
		  ${p.post|n}
		</div>
		</div>
	      </div>
	  % endfor
	% endif
	##<div class="g-recaptcha" data-sitekey="6Lf5AP8SAAAAADKrZCOeF1qRqSdTTXJfrhWmQeb5"></div>
	</div>	
    </div>
 </div>     
    
