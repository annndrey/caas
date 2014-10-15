## -*- coding: utf-8 -*-
<%inherit file="caas:templates/template_base.mak"/>
  
## navbar was here

    % if session_message and session_message[0]=='edited':
      <div class="alert alert-success" role="alert">Your article is successfully saved!</div>
    % endif
    
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
		 <select class="form-control" id="inputStatus" name="inputStatus">
		   % for s in article_status.keys():
		     % if edit:
		       % if s == article.status:
			 <option selected value="${s}">${article_status[s]}</option>
		       % else:
			 <option value="${s}">${article_status[s]}</option>
		       % endif
		     % else:
		       % if s == 'draft':
			 <option selected value="${s}">${article_status[s]}</option>
		       % else:
			 <option value="${s}">${article_status[s]}</option>
		       % endif
		     % endif   
		   % endfor
		 </select>
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
	<input type="text" class="form-control" id="inputURL" name="inputURL" placeholder="yourarticleurl"
	       % if edit:
		 value="${article.url}"
	       % endif
	       >
      </div>
      
      ## add status, sep_url, left_bracket_url, right_bracket_url here
      
      <div class="col-md-8 col-md-offset-2">
     	<textarea class="form-control" id="inputArticle" name="inputArticle" placeholder="Основной текст" rows=20>
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
    </div>
  </div>
