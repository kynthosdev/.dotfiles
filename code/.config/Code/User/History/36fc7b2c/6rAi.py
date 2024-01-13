import logging

from typing import List

from random import choice, randint
from attr import define, field

import chrmndr.engine.random_policy as rp
from chrmndr.models.card import Card

from chrmndr.utils import build_from_decklist, build_from_file

# import chrmndr.actions as action
# from chrmndr.events import player_events
# from chrmndr.utils import find_cards_by_type

logger = logging.getLogger("game")


@define
class Player:
    name: str
    decklist: dict

    library: List[Card] = field()
    @library.default
    def build_deck(self):
        return build_from_file(decklist=self.decklist, owner=self.name)

    life: int = 20
    hand_size: int = 7
    poison_counter: int = 0
    has_priority: bool = False
    has_played_land: bool = False
    has_lost: bool = False
    has_won: bool = False

    abilities: List[str] = field(default=list)
    hand: List[Card] = field(factory=list)
    # library: List[Card] = field(factory=list)
    # graveyard: List[Card] = field(factory=list)

    mana_pool: List[Card] = field(factory=list)

    # def get_subscribers(self, event: str):
    #     return self.events[event]

    # def register(self, event: str, card_name: str, callback=None):
    #     if callback == None:
    #         callback = getattr(card_name, "update")
    #     self.get_subscribers(event)[card_name] = callback

    # def unregister(self, event: str, card_name: str):
    #     del self.get_subscribers(event)[card_name]

    # def trigger(self, event: str):
    #     for subscriber, callback in self.get_subscribers(event).items():
    #         callback()

    # def take_damage(self, damage):
    #     logger.info(f"Player {self.id} loses {damage} life")
    #     self.life -= damage
    #     return self.life

    def draw_opening_hand(self):
        for _ in range(self.hand_size):
            card: Card = self.library.pop()
            logger.info(f"{str(self.name).upper()} draws {card}")
            self.hand.append(card)

    # def concedes(self):
    #     self.has_lost = True
    #     logger.info(f"Player{self.id} has lost")
    #     # self.trigger("on_losing")

    # def has_lethal_damage(self):
    #     if self.life < 1:
    #         self.has_lost = True
    #         logger.info(f"Player{self.id} has lost")
    #         return True

    # def pass_priority(self):
    #     logger.info(f"Player {self.id} passes priority")
    #     self.has_priority = False

    # def gain_priority(self):
    #     logger.info(f"Player {self.id} gains priority")
    #     self.has_priority = True

    def draw(self, number_of_cards: int):
        for _ in range(number_of_cards):
            if self.is_decked():
                break
            card: Card = self.library.pop()
            logger.info(f"{str(self.name).upper()} draws {card}")
            self.hand.append(card)
        return self.has_lost

    # # TODO: Implement taking a mulligan
    # def take_mulligan(self):
    #     # logger.info(f"Player {self.id} decides against mulligan")
    #     pass

    def discard_to_hand_size(self):
        cards_to_discard = len(self.hand) - self.hand_size
        if cards_to_discard > 0:
            logger.info(f"Discard {cards_to_discard} cards to hand size")
            self.discard(cards_to_discard)

    def discard(self, number_of_cards: int):
        for _ in range(number_of_cards):
            card = rp.discard_random_card(self.hand)
            self.hand.remove(card)

    def cast_from_hand(self, cards: List[Card]):
        card = rp.select_random_card(cards)
        logger.info(f"{str(self.name).upper()} casting {card.name} from hand")
        self.hand.pop(self.hand.index(card))

    # def play_from_hand_by_type(self, card_type: str):
    #     cards = find_cards_by_type(self.hand, card_type)
    #     return self.play_from_hand(cards)

    # def reset_mana_pool(self):
    #     self.mana_pool = []

    #     for card in self.battlefield:
    #         if len(card.produced_mana) > 0:
    #             mana = chain(self.mana_pool, card.produced_mana)
    #             self.mana_pool = list(mana)

    # def add_to_mana_pool(self, card: Card):
    #     if len(card.produced_mana) > 0:
    #         mana = chain(self.mana_pool, card.produced_mana)
    #         self.mana_pool = list(mana)

    # def pay_casting_cost(self, card: Card):
    #     pass

    def reset_attrs(self):
        logger.info(f"Resetting player attributes")
        self.has_played_land = False

    def is_decked(self):
        if len(self.library) < 1:
            self.has_lost = True
            logger.info(f"{str(self.name).upper()} has lost - No more cards in library")
            return True


# TODO: Implement triggers on events
# TODO: Implement poison counters
