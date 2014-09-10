#!/usr/bin/env python                                                                                                   # -*- coding: utf-8

from pyramid.view import (
    notfound_view_config,
    forbidden_view_config,
    view_config
)
from pyramid.security import (
    authenticated_userid,
    forget,
    remember
)
from pyramid.httpexceptions import (
    HTTPForbidden,
    HTTPFound,
    HTTPNotFound,
    HTTPSeeOther
)
import datetime
from pyramid.response import Response
from sqlalchemy.exc import DBAPIError
from sqlalchemy import func
from .models import (
    DBSession,
    Post,
    User, 
    Article
    )
import re 
_re_login = re.compile(r'^[\w\d._-]+$')

@view_config(route_name='main', renderer='template_main.mak')
def main_view(request):
	articles = DBSession.query(Article).all()
	tpldef = {'message': 'Welcome to the main page. Here is the list of all articles', 'articles':articles }
	if authenticated_userid(request):
		tpldef.update({'auth':True})
	return tpldef

@view_config(route_name='article', renderer='template_article.mak')
def article_view(request):
	article_url = request.matchdict.get('url', None)
	article = DBSession.query(Article).filter(Article.url==article_url).first()
	tpldef = {'article':article}
	if authenticated_userid(request):
		tpldef.update({'auth':True})
	return tpldef

@view_config(route_name='newarticle', renderer='template_newarticle.mak')
def add_article(request):
	if not authenticated_userid(request):
		request.session.flash({
				'class' : 'warning',
				'text'  : 'You need to log in to access this page'
				})
		return HTTPSeeOther(location=request.route_url('login'))
	if not request.POST:
		tpldef = {}
		tpldef.update({'authuser':authenticated_userid(request)})
		return tpldef
	else:
		art_name = request.POST.get('inputMainname', None)
		art_uppername = art_name
		art_kwords = request.POST.get('inputKeywords', None)
		art_descr = request.POST.get('inputDescr', None)
		art_text = request.POST.get('inputArticle', None)
		art_url = request.POST.get('inputURL', None)
		newarticle = Article(art_name, art_uppername, art_kwords, art_url, art_text, art_descr, datetime.datetime.now(), authenticated_userid(request))
		DBSession.add(newarticle)

		return HTTPSeeOther(location=request.route_url('main'))

@view_config(route_name='newpost')
def add_new_post(request):
	if not authenticated_userid(request):
		request.session.flash({
				'class' : 'warning',
				'text'  : 'You need to log in to access this page'
				})
		return HTTPSeeOther(location=request.route_url('login'))
	if not request.POST:
		return HTTPSeeOther(location=request.route_url('home'))
	else:
		message = request.POST.get('userpost', None)
		if message:
			newpost = Post(date = datetime.datetime.now(), page='discuss', name=authenticated_userid(request), ip=request.remote_addr, post=message )
			DBSession.add(newpost)
		return HTTPSeeOther(location=request.route_url('home'))

@view_config(route_name='home', renderer='template_discuss.mak')
@view_config(route_name='home_slash', renderer='template_discuss.mak')
@view_config(route_name='home:page', renderer='template_discuss.mak')
def discuss_view(request):
	on_page = 20
	first = 0
	last = 20
	page = request.matchdict.get('page', None)

	if not authenticated_userid(request):
		request.session.flash({
				'class' : 'warning',
				'text'  : 'You need to log in to access this page'
				})
		return HTTPSeeOther(location=request.route_url('login'))
	else:
		max_page = DBSession.query(func.count(Post.id))[-1][-1]//on_page
		if page and int(page) > 0:
			page = int(page) - 1
			first = on_page * page
			last = first + on_page
			if int(page) > max_page:
				return HTTPSeeOther(location=request.route_url('home:page',page=max_page))
		posts = DBSession.query(Post).filter(Post.page == 'discuss').order_by(Post.id.desc()).slice(first, last)
		current_time = datetime.datetime.now()
		week_ago = current_time - datetime.timedelta(weeks=1)

		newcomments = DBSession.query(Post).filter(Post.date > week_ago).filter(Post.page != 'discuss')

		tpldef = {'posts': posts,
				  'page': page,
				  'max_page':max_page,
				  'authuser':authenticated_userid(request),
				  'newcommentscount':newcomments.count()
				  }
		return tpldef

@view_config(route_name='login', renderer='login.mak')
def login_view(request):
	login = ''
	did_fail = False
	nxt = request.route_url('home')
	if authenticated_userid(request):
		return HTTPSeeOther(location=nxt)
	if 'submit' in request.POST:
		csrf = request.POST.get('csrf', '')
		login = request.POST.get('user', '')
		passwd = request.POST.get('pass', '')

		if (csrf == request.session.get_csrf_token()) and login:
			sess = DBSession()
			q = sess.query(User).filter(User.name == login)
			for user in q:
				if user.password == passwd:
					headers = remember(request, login)
					request.response.headerlist.extend(headers)
					return HTTPFound(request.route_url('home'), headers=headers)
		did_fail = True
	tpldef = {
		'login'       : login,
		'failed'      : did_fail,
		}
	return tpldef

@view_config(route_name='edit')
def discuss_edit(request):
	if not authenticated_userid(request):
		request.session.flash({
				'class' : 'warning',
				'text'  : 'You need to log in to access this page'
				})
		return HTTPSeeOther(location=request.route_url('login'))
	else:
		if request.POST:
			csrf = request.POST.get('csrf', '')
			if (csrf == request.session.get_csrf_token()):
				newpost = request.POST.get('newpost', '')
				post = DBSession.query(Post).filter(Post.id==request.matchdict['id']).first()
				if post.name == authenticated_userid(request):
					post.post = newpost
					DBSession.add(post)

		return HTTPSeeOther(location=request.route_url('home'))


@view_config(route_name='remove')
def remove_post(request):
	if not authenticated_userid(request):
		request.session.flash({
				'class' : 'warning',
				'text'  : 'You need to log in to access this page'
				})
		return HTTPSeeOther(location=request.route_url('login'))
	else:
		post = DBSession.query(Post).filter(Post.id==request.matchdict['id']).first()
		if post.name == authenticated_userid(request):
			DBSession.delete(post)
			#userid = DBSession.query(User).filter(User.name==authenticated_userid(request))
			return HTTPSeeOther(location=request.route_url('home'))
		return HTTPSeeOther(location=request.route_url('home'))

@view_config(route_name='logout')
def logout_view(request):
    if authenticated_userid(request):
        headers = forget(request)
        return HTTPFound(request.route_url("login"), headers=headers)
    else:
        return HTTPFound(request.route_url("login"))
