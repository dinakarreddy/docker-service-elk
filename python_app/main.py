import os
import logging
import logging.handlers
import logging.config

BASE_DIR = os.path.dirname(os.path.dirname(__file__))

LOG_CONFIG = {
    'version': 1,
    'disable_existing_loggers': True,
    'formatters': {
        'verbose': {
            'format': "[%(asctime)s] %(levelname)s [%(name)s: %(funcName)s: %(lineno)s] %(message)s",
            'datefmt': "%d/%b/%Y %H:%M:%S"
        },
    },
    'handlers': {
        'console': {
            'level': 'INFO',
            'class': 'logging.StreamHandler',
            'formatter': 'verbose'
        },
        'logstash': {
            # debug info like line numbers are not logged unless it is an error message
            'level': 'INFO',
            'class': 'logstash.TCPLogstashHandler',
            'host': 'localhost',
            'port': 5959, # Default value: 5959
            'version': 1, # Version of logstash event schema. Default value: 0 (for backward compatibility of library)
            'message_type': 'logstash',  # 'type' field in logstash message. Default value: 'logstash'.
            'fqdn': True, # Fully qualified domain name. Default value: false.
            'tags': ['tag1', 'tag2'], # Default: None. A list of tags field will be created in es
        },
    },
    'loggers': {
        '': {
            'handlers': ['console', 'logstash'],
            'level': 'INFO',
            'propagate': False,
        },
    }
}
logging.config.dictConfig(LOG_CONFIG)
LOGGER = logging.getLogger(__name__)

def main():
    import time
    while True:
        try:
            LOGGER.info("Test info log")
            raise Exception("abcd")
        except Exception as e:
            LOGGER.error("Test error log", exc_info=True)
        finally:
            time.sleep(1)

if __name__ == '__main__':
    main()
