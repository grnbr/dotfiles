import logging
import time

logger = logging.getLogger(__name__)
WARNINGS_LOG_PATH = "/tmp/setup-warnings.log"


def setup_logging() -> None:
    log_path = f"/tmp/setup-{int(time.time())}.log"
    logging.basicConfig(
        level=logging.INFO,
        format="%(message)s",
        handlers=[
            logging.StreamHandler(),
            logging.FileHandler(log_path),
            _warnings_handler(),
        ],
    )
    logger.info("Logging to %s", log_path)


def _warnings_handler() -> logging.Handler:
    handler = logging.FileHandler(WARNINGS_LOG_PATH)
    handler.setLevel(logging.WARNING)
    return handler
