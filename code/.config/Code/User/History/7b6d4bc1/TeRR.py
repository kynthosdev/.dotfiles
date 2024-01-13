import json
import logging
from os import path
import chrmndr.engine.cards as c

from typing import List
from chrmndr.engine.random_policy import select_random_card
from chrmndr.models.card import Card


logger = logging.getLogger("game")


def build_from_decklist(decklist: List[dict], owner: str) -> List[Card]:
    cards = []
    logger.info(f"Building deck")
    for obj in decklist:
        # card_from_str = getattr(c, "Plains")
        for _ in range(obj["qty"]):
            cards.append(obj["card"])

    logger.debug(f"Build deck of size {len(cards)}")
    return cards


def build_from_file(decklist: List[dict], owner: int) -> List[Card]:
    deck = []
    # decklist = [
    #     {"filename": "assets/plains.json", "qty": 7},
    #     {"filename": "assets/dauntless_bodyguard.json", "qty": 4},
    # ]

    for obj in decklist:
        object = path.join(path.dirname(path.abspath(__file__)), obj["filename"])
        f = open(object)
        card = json.load(f)

        logger.info(f"Building deck")
        for _ in range(obj["qty"]):
            _card_name = str(card["name"]).replace(" ", "")
            _card = getattr(c, _card_name)
            deck.append(
                _card(
                    name=card["name"],
                    owner=str(owner).upper(),
                    type_line=card["type_line"],
                )
            )

        f.close()

    logger.debug(f"Number of cards in deck is {len(deck)}")
    logger.debug(f"Build complete")

    return deck


def find_cards_by_type(cards: List[Card], card_type: str):
    filtered_cards = filter(lambda card: card.type_line.find(card_type) > -1, cards)
    return list(filtered_cards)
