## -*- coding: utf-8 -*-
<%inherit file="caas:templates/template_base.mak"/>

<script src="${req.static_url('caas:static/js/injectText.js" type="text/javascript"></script>

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
	    <a type="button" href="javascript:void(0);" onclick="injectText('text','link');" >Ссылка</a> 
	    <a type="button" href="javascript:void(0);" onclick="injectText('text','pict');" >Картинка</a>
	    <button type="submit" class="btn btn-default pull-right" id="submit" name="submit" title="Послать" tabindex="3">Послать</button>
     	  </div>
	</div>
      </form>
    </div>  
    
    % for p in posts:
      <div class="row">
	<div class="col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2" align='justify'>
     	  <h4>${p.name}: <small>${p.date.strftime('%d/%m/%Y %H:%M')}</small>
	    % if p.name == authuser:
	      <a data-toggle="modal" data-target="#editModal${p.id}" data-toggle="tooltip" data-placement="top" title="Править"><span class="glyphicon glyphicon-pencil"></span></a>
	    % endif
	    <div class="modal fade" id="editModal${p.id}" tabindex="-1" role="dialog" aria-labelledby="editModalLabel"${p.id} aria-hidden="true">
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
	    
	    ## <a data-toggle="tooltip" data-placement="top" title="Ответить" href="/reply"><span class="glyphicon glyphicon-comment"></span></a>
	  </h4>
	      </span>${p.post|n}
	      
	</div>
      </div>
    % endfor
    ##  <ul class="pager">
    ${navbar(page, max_page)}
    
  
  </div>