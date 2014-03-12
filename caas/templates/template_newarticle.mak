## -*- coding: utf-8 -*-
<%inherit file="caas:templates/template_base.mak"/>

<div class="container">
<div class="page-header">
     <h2>Новая статья</h2><small>кукареку!</small>

</div>     
<nav class="navbar navbar-default navbar-ststic-top" role="navigation">
     <a class="navbar-brand" href="#">Новая статья</a>
     <div class="container">
     <p class="navbar-text">Шалом, ${authuser}! 

     <a data-toggle="tooltip" data-placement="top" title="Выйти" href="${request.route_url('logout')}"><span class="glyphicon glyphicon-circle-arrow-right"></span></a>
     </p>
     </div>
</nav>

     <div class="row">
     	 <form role="form" method="post" action="${req.route_url('newarticle')}">
     	 <div class="form-group">
		<label for="inputMainname" class="col-sm-2 control-label">Название</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputMainname" name="inputMainname" placeholder="Название">
    </div>
  </div>
  <div class="form-group">
    <label for="inputKeywords" class="col-sm-2 control-label">Ключевые слова</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputKeywords" name="inputKeywords" placeholder="новая статья, путешествия, приключения">
    </div>
  <div class="form-group">
    <label for="inputDescr" class="col-sm-2 control-label">Описание</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputDescr" name="inputDescr" placeholder="Описание">
    </div>
  <div class="form-group">
    <label for="inputURL" class="col-sm-2 control-label">Адрес страницы</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputURL" name="inputURL" placeholder="yourarticle">
    </div>
     		     <div class="col-md-8 col-md-offset-2">
		     	  
     		     	  <textarea class="form-control" id="inputArticle" name="inputArticle" data-provide="markdown" placeholder="Писать сюда" rows=20></textarea>
			  <input type="hidden" id="csrf" name="csrf" value="${req.session.get_csrf_token()}" />
			  <button type="submit" class="btn btn-default pull-right" id="submit" name="submit" title="Опубликовать" tabindex="3">Послать</button>
     		     </div>
		</div>
    	  </form>
     </div>  
</div>