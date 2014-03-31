## -*- coding: utf-8 -*-
<%inherit file="caas:templates/template_base.mak"/>

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

<div class="container">
<div class="page-header">
     <h2>Клубные дела</h2><small>куку</small>

</div>     
<nav class="navbar navbar-default navbar-ststic-top" role="navigation">
     <a class="navbar-brand" href="/">Глагне</a>
     <div class="container">
     <p class="navbar-text">Шалом, ${authuser}! 

     <a data-toggle="tooltip" data-placement="top" title="Выйти" href="${request.route_url('logout')}"><span class="glyphicon glyphicon-circle-arrow-right"></span></a>

     <ul class="nav navbar-nav">
        <li><a href="/newcomments">новые комментарии <span class="badge">${str(newcommentscount)}</span></a></li>
        <li><a href="#">остальное</a></li>
     </ul>
          </p>
     </div>
</nav>

${navbar(page, max_page)}
     <div class="row">
     	  <form role="form" method="post" action="${req.route_url('newpost')}">
     	  	<div class="form-group">
     		     <div class="col-md-8 col-md-offset-2">
     		     	  <textarea class="form-control" id="userpost" name="userpost" placeholder="Нам очень важно ваше мнение" rows=2></textarea>
			  <input type="hidden" id="csrf" name="csrf" value="${req.session.get_csrf_token()}" />
			  <button type="submit" class="btn btn-default pull-right" id="submit" name="submit" title="Послать" tabindex="3">Послать</button>
     		     </div>
		</div>
    	  </form>
     </div>  

     % for p in posts:
       <div class="row">
       	    <div class="col-md-8 col-md-offset-2" align='justify'>
     		 <h4>${p.name}: <small>${p.date.strftime('%d/%m/%Y %H:%M')}</small>
		 % if p.name == authuser:
		 	<button class="btn btn-default btn-xs" data-toggle="modal" data-target="#editModal${p.id}" data-toggle="tooltip" data-placement="top" title="Править"><span class="glyphicon glyphicon-pencil"></span></button>
		 % endif
		 <div class="modal fade" id="editModal${p.id}" tabindex="-1" role="dialog" aria-labelledby="editModalLabel"${p.id} aria-hidden="true">
  		 <div class="modal-dialog">
    		 <div class="modal-content">
      		 <div class="modal-header">
        	 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        	 <h4 class="modal-title" id="editModalLabel${p.id}">Правка записи</h4>
      		 </div>
      		 <div class="modal-body">
        	 <form role="form" method="post" action="/edit/${p.id}">
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
		   <button class="btn btn-default btn-xs" data-toggle="modal" data-target=".bs-delete-modal-sm${p.id}"><span class="glyphicon glyphicon-trash"></span></button>
		   <div class="modal fade bs-delete-modal-sm${p.id}" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
		     <div class="modal-dialog">
		       <div class="modal-content">
		       <div class="modal-header">
		       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		       <h4 class="modal-title" id="deleteModalLabel${p.id}">Удаление записи</h4>
		       </div>
		       <div class="modal-body">
      		       <a href="/remove/${p.id}">Да, удалите немедленно!</a>
		       </div>
		       <div class="modal-footer">
		       <button type="button" class="btn btn-default" data-dismiss="modal">Отменить</button>
		       </div>
		       </div>
		     </div>
		   </div>
		 % endif

		 <a role="button" class="btn btn-default btn-xs" data-toggle="tooltip" data-placement="top" title="Ответить" href="/reply"><span class="glyphicon glyphicon-comment"></span></a>
		 </h4>
		 </span>${p.post|n}

	    </div>
       </div>
      % endfor
   <ul class="pager">
${navbar(page, max_page)}

</div>