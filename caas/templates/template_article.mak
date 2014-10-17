## -*- coding: utf-8 -*-

<%inherit file="caas:templates/template_base.mak"/>

  <div class="container">
    <div class="row">
      <div class="col-md-8 col-md-offset-2" align='justify'>
	% if article:
	  <p>
	    <a href="${request.route_url('edit', pub='article', id=article.id)}">Edit</a>
	    <a data-toggle="modal" data-target=".modal-remove">Remove</a>

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

	  </p>
	  ## should replace src=" with src="static/picts/
	  ${article.maintext|n}
	% else:
	  There's no such article
	% endif  	
      </div>
    </div>
  </div>
  
