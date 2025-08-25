import os
from datetime import timedelta

import redis


class BaseConfig():
    """Base configuration class."""
    DEBUG = os.getenv('FLASKAPP_DEBUG', 'True').lower() in ['true', '1', 'yes']
    TESTING = False

    # SESSIONS on REDIS
    SESSION_TYPE = 'redis'
    SESSION_REDIS = redis.from_url("redis://redis:6379/0")
    SESSION_PERMANENT = True  # Ativar sessões permanentes com TTL
    SESSION_USE_SIGNER = True
    SESSION_KEY_PREFIX = 'session:'
    SESSION_SERIALIZATION_FORMAT = 'msgpack'  # Usar msgpack para melhor compatibilidade

    # Tempo de vida das sessões (30 dias)
    PERMANENT_SESSION_LIFETIME = timedelta(days=30)
    # Tempo de vida das sessões temporárias (2 horas)
    TEMPORARY_SESSION_LIFETIME = timedelta(hours=2)

    SECRET_KEY = os.getenv('FLASKAPP_SECRET_KEY', 'supersecretkey')
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))
# End class BaseConfig


class DevelopmentConfig(BaseConfig):
    """Development configuration class."""
    DEBUG = True
# End class DevelopmentConfig


class ProductionConfig(BaseConfig):
    """Production configuration class."""
    DEBUG = False
# End class ProductionConfig
