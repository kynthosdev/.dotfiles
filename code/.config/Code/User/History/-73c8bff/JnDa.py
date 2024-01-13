import logging
from random import choice
from typing import List

from attr import define, field

from chrmndr.models.player import Player
from chrmndr.models.card import Card

logger = logging.getLogger("game")


@define
class GameState:
    players: List[Player]

    starting_player: Player = field()
    active_player: Player = field()
    non_active_player: Player = field()

    turn: int = field(default=1)
    player_with_priority: Player = field(default=None)

    @starting_player.default
    def get_starting_player(self):
        return choice(self.players)

    @active_player.default
    def init_active_player(self):
        return self.starting_player

    @non_active_player.default
    def init_non_active_player(self):
        return self.players[self.players.index(self.starting_player) - 1]

    # player_with_priority_index: int = field(init=False)

    # stack: List[Card] = field(factory=list)
    # battlefield: List[Card] = field(factory=list)
    exile: List[Card] = field(factory=list)
    # command: List[Card] = field(factory=list)
    # ante: List[Card] = field(factory=list)

    # @events.default
    # def events_to_dict(self):
    #     return {event: dict() for event in game_state_events()}

    # def get_subscribers(self, event: str):
    #     return self.events[event]

    # def register(self, event: str, card_name: str, callback=None):
    #     if callback == None:
    #         callback = getattr(card_name, "update")
    #     self.get_subscribers(event)[card_name] = callback

    # def unregister(self, event: str, card_name: str):
    #     del self.get_subscribers(event)[card_name]

    def pass_turn(self, player: Player):
        logger.info(f"{str(player.name).upper()} has passed the turn")
        self.non_active_player = player
        logger.info(f"Non-Active player: {str(self.non_active_player.name).upper()}")
        self.active_player = self.players[not self.players.index(player)]
        logger.info(f"Active player: {str(self.active_player.name).upper()}")
        return

    def player_gain_priority(self, player: Player):
        self.player_with_priority = player
        logger.info(f"{str(self.player_with_priority.name).upper()} gains priority")
        return

    def is_game_over(self):
        for player in self.players:
            if player.has_lost:
                return True
        return
