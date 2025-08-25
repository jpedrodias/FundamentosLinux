from random import choice
from os import listdir, path


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

app.config['RANDOM_IMGS'] = listdir(path.join(app.config['BASE_DIR'], 'static/random.img/'))


# Disponibilizar token CSRF globalmente nos templates
@app.context_processor
def inject_csrf_token():
    from flask_wtf.csrf import generate_csrf
    return dict(csrf_token=generate_csrf)
# End inject_csrf_token


@app.route('/')
@limiter.limit("15 per minute")
def index():
    ip = get_real_ip()
    redis_url = app.config['SESSION_REDIS'].connection_pool.connection_kwargs
    
    # Monta a URL do redis a partir dos kwargs
    host = redis_url.get('host', 'localhost')
    port = redis_url.get('port', 6379)
    db = redis_url.get('db', 0)
    url = f"redis://{host}:{port}/{db}"
    
    r = redis.from_url(url)
    r.incr(f"visits:{ip}")  # incrementa o contador para o IP
    count = r.get(f"visits:{ip}")
    visit_count = count.decode() if count else "1"
    
    img_file = choice(app.config['RANDOM_IMGS'])
    return render_template('index.html', user_ip=ip, visit_count=visit_count, picture=img_file)

index = limiter.limit("60 per minute")(index)

if __name__ == '__main__':
    app.run(debug=app.config['DEBUG'], host='0.0.0.0', port=5000)
    