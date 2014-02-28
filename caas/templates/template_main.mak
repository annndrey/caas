## -*- coding: utf-8 -*-
<%inherit file="caas:templates/template_base.mak"/>
% if auth:
<a href="${request.route_url('logout')}">Logout</a>
<a href="${request.route_url('home')}">Discuss</a>
% else:
<a href="${request.route_url('login')}">Login</a>
% endif
   <p class="text-justify bg-info">
   ${message}
   </p>
