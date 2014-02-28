## -*- coding: utf-8 -*-
<%inherit file="caas:templates/template_base.mak"/>
<%block name="title">Login</%block>
<%block name="head">\
	<link rel="stylesheet" href="${req.static_url('caas:static/css/login.css')}" type="text/css" />
</%block>

<div class="container">
<form class="form-signin" role="form" method="post" action="${req.route_url('login')}">
	<h2 class="form-signin-heading">Login</h2>
% for msg in req.session.pop_flash():
	<div class="alert alert-${msg['class'] if 'class' in msg else 'success'} alert-dismissable" role="alert">
		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		${msg['text']}
	</div>
% endfor
  	<input type="hidden" id="csrf" name="csrf" value="${req.session.get_csrf_token()}" />
	<input type="text" class="form-control" placeholder="имя" required="required" autofocus="autofocus" id="user" name="user" title="Введите имя пользователя" value="" maxlength="254" tabindex="1" autocomplete="off" />
	<input type="password" class="form-control" placeholder="пароль" required="required" id="pass" name="pass" title="Введите пароль" value="" maxlength="254" tabindex="2" autocomplete="off" />
	<button type="submit" class="btn btn-lg btn-primary btn-block" id="submit" name="submit" title="Войти" tabindex="3">Войти</button>
</form>

</div>

