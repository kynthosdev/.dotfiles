import logging
from random import shuffle
from typing import List
from chrmndr.models.card import Card

logger = logging.getLogger("game")


def shuffle_cards(cards) -> List[Card]:
    logger.info(f"Shuffling...")
    shuffle(cards)
    return cards


def exile():
    pass


def transform():
    pass


def pay_cost():
    pass