from flask import Flask, render_template
from flask_session import Session
from flask_wtf.csrf import CSRFProtect

import redis

from flask_limiter import Limiter

def get_real_ip():
    from flask import request
    ip_address = request.headers.get('Cf-Connecting-Ip')
    if not ip_address:
        # Tenta pegar o último IP da cadeia de proxies
        ip_address = request.access_route[-1] if request.access_route else request.remote_addr
    return ip_address

app = Flask(__name__)
app.config.from_object('config.DevelopmentConfig')  # Use DevelopmentConfig by default  

Session(app)

csrf = CSRFProtect(app)

# Configurar Flask-Limiter com Redis
limiter = Limiter(
    key_func=get_real_ip,
    app=app,
    storage_uri="redis://redis:6379/0"
)


# Disponibilizar token CSRF globalmente nos templates
@app.context_processor
def inject_csrf_token():
    from flask_wtf.csrf import generate_csrf
    return dict(csrf_token=generate_csrf)
# End inject_csrf_token


@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=app.config['DEBUG'], host='0.0.0.0', port=5000)
    