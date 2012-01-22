require 'rack/utils'

class FlashSessionCookieMiddleware
  def initialize(app, session_key = '_session_id')
    @app = app
    @session_key = session_key
  end

  def call(env)
    if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
      #params = ::Rack::Utils.parse_query(env['QUERY_STRING'])

      #unless params[@session_key].nil?
      #  env['HTTP_COOKIE'] = "#{@session_key}=#{params[@session_key]}".freeze
      #end

      # Here's the goods
      #unless params['_http_accept'].nil?
      #  env['HTTP_ACCEPT'] = "#{params['_http_accept']}".freeze
      #end

      req = Rack::Request.new(env)
      env['HTTP_COOKIE'] = [ @session_key,req.params[@session_key] ].join('=').freeze unless req.params[@session_key].nil?
      env['HTTP_ACCEPT'] = "#{req.params['_http_accept']}".freeze unless req.params['_http_accept'].nil?

      # Set current_user to pass the authenticated_system ->:login_required
      #unless params['iduser'].nil?
      #  @current_user = User.find_by_id(params['iduser'])
      #end
    end

    @app.call(env)
  end
end