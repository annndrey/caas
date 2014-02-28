from pyramid.authentication import AuthTktAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy
from pyramid.config import Configurator
from pyramid.session import UnencryptedCookieSessionFactoryConfig
from sqlalchemy import engine_from_config

from .models import (
    DBSession,
    Base,
	Post,
	User
    )
sessionfactory = UnencryptedCookieSessionFactoryConfig('t,fysdhjn')
authn_policy = AuthTktAuthenticationPolicy( 'secret')
authz_policy = ACLAuthorizationPolicy()

def main(global_config, **settings):
	""" This function returns a Pyramid WSGI application.
	"""
	engine = engine_from_config(settings, 'sqlalchemy.')
	DBSession.configure(bind=engine)
	Base.metadata.bind = engine
	config = Configurator(settings=settings, session_factory=sessionfactory)
	config.set_authentication_policy(authn_policy)
	config.set_authorization_policy(authz_policy)
	config.add_static_view('static', 'static', cache_max_age=3600)
	config.add_route('home', '/discuss')
	config.add_route('home_slash', '/discuss/')
	config.add_route('home:page', '/discuss/{page:\d+}')
	config.add_route('login', '/login')
	config.add_route('edit', '/edit/{id:\d+}')
	config.add_route('remove', '/remove/{id:\d+}')
	config.add_route('newpost', '/newpost')
	config.add_route('logout', '/logout')
	config.add_route('main', '/')
	config.scan()
	return config.make_wsgi_app()
