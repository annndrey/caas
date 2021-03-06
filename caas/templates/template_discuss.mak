## -*- coding: utf-8 -*-
<%inherit file="caas:templates/template_base.mak"/>

<script src="${req.static_url('caas:static/js/injectText.js')}" type='text/javascript'></script>


  <%def name="navbar(page, maxpage)">
    <ul class="pager">
      % if not page:
	<li class="previous disabled"><a href="${request.route_url('home')}"> &larr; Вперед</a></li>
	<li class="next"><a href="${request.route_url('home')}/2">Назад &rarr;</a></li>
      % else:
	<li class="previous"><a href="${request.route_url('home')}/${page}"> &larr; Вперед</a></li>
	% if int(page) < int(maxpage):
	  <li class="next"><a href="${request.route_url('home')}/${page + 2}">Назад &rarr;</a></li>
	% else:
	  <li class="next disabled"><a href="${request.route_url('home')}/${page + 1}">Назад &rarr;</a></li>
	% endif
      % endif  
    </ul>
  </%def>

  ${navbar(page, max_page)}
  <div class="inner">  
    <div class="row">
      <form role="form" method="post" action="${req.route_url('newpost')}">
	<div class="form-group">
     	  <div class="col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2">
     	    <textarea class="form-control" id="userpost" name="userpost" placeholder="Куку!" rows=2></textarea>
	    <input type="hidden" id="csrf" name="csrf" value="${req.session.get_csrf_token()}" />
	    <input type="hidden" id="ppage" name="ppage" value="discuss" />
	    <button style="margin: 10px 0; margin-left: 2px;" type="submit" class="btn btn-default pull-right" id="submit" name="submit" title="Послать" tabindex="3">Послать</button>
	    <a style="margin: 10px 0; margin-left: 2px;" href="javascript:void(0);" class="btn btn-default pull-right" onclick="injectText('userpost','link');" >Ссылка</a> 
	    <a style="margin: 10px 0; margin-left: 2px;" href="javascript:void(0);" class="btn btn-default pull-right" onclick="injectText('userpost','pict');" >Картинка</a>
	    <a style="margin: 10px 0; margin-left: 2px;" data-toggle="modal" data-target="#uploadModal" class="btn btn-default pull-right">Загрузить</a>
     	  </div>
	</div>
      </form>

      <div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="uploadModal" aria-hidden="true">
  	<div class="modal-dialog">
    	  <div class="modal-content">
      	    <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="uploadModal">Загрузить что-нибудь</h4>
      	    </div>
      	    <div class="modal-body">
              <form class="form-inline" enctype="multipart/form-data" id="fileupload" name="fileupload" role="form" method="post" action="#">
		<div class="form-group">
		  <input type="file" name="file" size=60>
		</div>
		<div class="form-group">
		  <input type='checkbox' name='preserve' value='preserve'>Сохранить навсегда!!
		</div>
		<div class="form-group">
		  <input type="hidden" id="csrf" name="csrf" value="${req.session.get_csrf_token()}" />
		</div>
      		<div class="modal-footer">
		  <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
		  <button type="submit" class="btn btn-primary">Загрузить</button>
		</div>
	      </form>
	    </div>
	  </div>
	</div>
      </div>
    </div>  
    <br>    
    % for p in posts:
      <div class="row">
	<div class="col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2" align='justify'>
	  <div class="panel panel-default">
	    <div class="panel-heading">
     	      <h4>${p.name}: <small>${p.date.strftime('%d/%m/%Y %H:%M')}</small>
		% if p.name == authuser:
		  <a data-toggle="modal" data-target="#editModal${p.id}"><span class="glyphicon glyphicon-pencil"></span></a>
		% endif

		<div class="modal fade" id="editModal${p.id}" tabindex="-1" role="dialog" aria-labelledby="editModalLabel${p.id}" aria-hidden="true">
  		  <div class="modal-dialog">
    		    <div class="modal-content">
      		      <div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        		<h4 class="modal-title" id="editModalLabel${p.id}">Правка записи</h4>
      		      </div>
      		      <div class="modal-body">
        		<form role="form" method="post" action="${request.route_url('edit', pub='post', id=p.id)}">
			  <textarea class="form-control" id="newpost" name="newpost" rows="4">${p.post|n}</textarea>
			  <input type="hidden" id="csrf" name="csrf" value="${req.session.get_csrf_token()}" />
      		      </div>
      		      <div class="modal-footer">
        		<button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
        		<button type="submit" class="btn btn-primary">Сохранить</button>
			</form>
		      </div>
		    </div>
		  </div>
		</div>
		% if p.name == authuser:
		  <a data-toggle="modal" data-target=".bs-delete-modal-sm${p.id}"><span class="glyphicon glyphicon-trash"></span></a>
		  <div class="modal fade bs-delete-modal-sm${p.id}" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		      <div class="modal-content">
			<div class="modal-header">
			  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			  <h4 class="modal-title" id="deleteModalLabel${p.id}">Удаление записи</h4>
			</div>
			<div class="modal-body">
      			  <a href="${request.route_url('remove', pub='post', id=p.id)}">Да, удалите немедленно!</a>
			</div>
			<div class="modal-footer">
			  <button type="button" class="btn btn-default" data-dismiss="modal">Отменить</button>
			</div>
		      </div>
		    </div>
		  </div>
		% endif
		
	    </div>
	    ## <a data-toggle="tooltip" data-placement="top" title="Ответить" href="/reply"><span class="glyphicon glyphicon-comment"></span></a>
	      </h4>
	  <div class="panel-body">
	    ${p.post|n}
	  </div>
	  
	  </div>
	</div>
      </div>
    % endfor
    ##  <ul class="pager">
  </div>
  ${navbar(page, max_page)}
