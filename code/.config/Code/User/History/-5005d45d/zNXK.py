import logging
import logging.config
from os import path, linesep

from models.player import Player
from engine.game import Game
from engine.game_state import GameState

log_file_path = path.join(path.dirname(path.abspath(__file__)), "logging.conf")
logging.config.fileConfig(log_file_path)

logger = logging.getLogger("game")


def start_simulation():
    logger.debug("Simulation started")
    players = []
    players.append(
        Player(
            name="hero",
            decklist=[
                {
                    "qty": 12,
                    "filename": "assets/plains.json",
                },
                {
                    "qty": 4,
                    "filename": "assets/dauntless_bodyguard.json",
                },
                {
                    "qty": 4,
                    "filename": "assets/hopeful_initiate.json",
                },
            ],
        )
    )
    players.append(
        Player(
            name="goldfish",
            decklist=[
                {
                    "qty": 20,
                    "filename": "assets/mountain.json",
                }
            ],
        )
    )

    state = GameState(players=players)
    
    game = Game(state=state)
    game.run()


if __name__ == "__main__":
    try:
        start_simulation()
        pass
    except SystemExit:
        pass
    except KeyboardInterrupt:
        logger.error("AI stopped by Keyboard Interrupt{0}{0}".format(linesep))
    except:
        logger.exception("Unexpected exception")
