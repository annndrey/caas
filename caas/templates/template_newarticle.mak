## -*- coding: utf-8 -*-
<%inherit file="caas:templates/template_base.mak"/>
  
  <div class="container">
  <div class="page-header">
    <h2>
      % if not edit:
	Новая статья
      % else:
	Правка "${article.mainname}"
      % endif
    </h2><small>кукареку!</small>
  </div>     
  
  <nav class="navbar navbar-default navbar-ststic-top" role="navigation">
  <a class="navbar-brand" href="#">
       % if not edit:
	 Новая статья
       % else:
	 Правка
       % endif
     </a>
     <div class="container">
       <p class="navbar-text">Шалом, ${authuser}! 
       
       <a data-toggle="tooltip" data-placement="top" title="Выйти" href="${request.route_url('logout')}"><span class="glyphicon glyphicon-circle-arrow-right"></span></a>
     </p>
     </div>
</nav>

<div class="row">
       % if not edit:
	  <form role="form" method="post" action="${req.route_url('newarticle')}">
          % else:  
          <form role="form" method="post" action="${req.route_url('edit', pub='article', id=article.id)}">
	  % endif
     	  <div class="form-group">
	   <label for="inputMainname" class="col-sm-2 control-label">Название</label>
		<div class="col-sm-10">
      <input type="text" class="form-control" id="inputMainname" name="inputMainname" placeholder="Название" 
	     % if edit:
	       value="${article.mainname}"
	     % endif
	     >
    </div>
	 </div>
  <div class="form-group">
    <label for="inputKeywords" class="col-sm-2 control-label">Ключевые слова</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputKeywords" name="inputKeywords" placeholder="новая статья, путешествия, приключения"
	     % if edit:
	       value="${article.keywords}"
	     % endif
	     >
    </div>
    <div class="form-group">
    <label for="inputDescr" class="col-sm-2 control-label">Описание</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputDescr" name="inputDescr" placeholder="Описание"
	     % if edit:
	       value="${article.descr}"
	     % endif
	     >
    </div>
    <div class="form-group">
    <label for="inputURL" class="col-sm-2 control-label">URL страницы</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputURL" name="inputURL" placeholder="yourarticle"
	     % if edit:
	       value="${article.url}"
	     % endif
	     >
    </div>
    <div class="col-md-8 col-md-offset-2">
     		       <textarea class="form-control" id="inputArticle" name="inputArticle" placeholder="Основонй текст" rows=20>
			    % if edit:
			      ${article.maintext|n}
			    % endif
			  </textarea>
			  <input type="hidden" id="csrf" name="csrf" value="${req.session.get_csrf_token()}" />
			  <a href="${req.referrer}" type="button" class="btn btn-default pull-right">Отменить</a>
			  <button type="submit" class="btn btn-default pull-right" id="submit" name="submit" title="Опубликовать" tabindex="3">Сохранить</button>
     		     </div>
  </div>
    	  </form>
  </div>  
</div>

