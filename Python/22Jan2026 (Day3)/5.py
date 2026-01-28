#Logging

import logging
import sys
from logging.handlers import RotatingFileHandler

FORMATTER = logging.Formatter(
    "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)

#Console Formatter
def get_console_handler():
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setFormatter(FORMATTER)
    return console_handler

#File handler with rotation
LOG_FILE = "helper.log"

def get_file_handler():
    file_handler = RotatingFileHandler(
        LOG_FILE,
        mode="a",
        maxBytes=1024,      # 1 KB for demonstration
        backupCount=5
    )
    file_handler.setFormatter(FORMATTER)
    return file_handler

#Logger Factory Function
def get_logger(logger_name):
    logger = logging.getLogger(logger_name)
    logger.setLevel(logging.DEBUG)
    logger.addHandler(get_console_handler())
    logger.addHandler(get_file_handler())
    logger.propagate = False
    return logger

#Using the logger
log = get_logger("loggy")

log.debug("This is a debug message")
log.info("This is an info message")
log.warning("This is a warning message")
log.error("This is an error message")
log.critical("This is a critical message")

#Logging exceptions
def main():
    try:
        result = 10 / 0
        print(result)
    except Exception as e:
        log.error(e)

main()