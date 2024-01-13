import logging
from random import shuffle
from typing import List

from chrmndr.models.card import Card
from chrmndr.engine.game_state import GameState as state

logger = logging.getLogger("game")


def shuffle_cards(cards) -> List[Card]:
    logger.info(f"Shuffling...")
    shuffle(cards)
    return cards


def exile(objects: List[Card]):
    pass


def transform():
    pass


def pay_craft_cost():
    pass