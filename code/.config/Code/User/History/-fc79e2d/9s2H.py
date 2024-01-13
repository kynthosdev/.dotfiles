import logging
from random import choice
from typing import List

from attr import define, field

import chrmndr.engine.mechanics.action as k_ac
import chrmndr.engine.phases as p
from chrmndr.engine.game_state import GameState

logger = logging.getLogger("game")


@define
class Game:
    state: GameState = field()

    game_over: bool = field(default=False)

    def starting_game(self):
        logger.info(f"Starting game")
        logger.info(f"Starting player: {str(self.state.starting_player.name).upper()}")
        logger.info(f"Active player: {str(self.state.active_player.name).upper()}")
        logger.info(
            f"Non-Active player: {str(self.state.non_active_player.name).upper()}"
        )

        for player in self.state.players:
            logger.info(f"{str(player.name).upper()} shuffling deck")
            k_ac.shuffle_cards(player.library)
            player.draw_opening_hand()

        # TODO: Implement mulligan process

    def run(self):
        self.starting_game()

        logger.info(f"Start match")
        while not self.game_over:
            logger.debug(f"XXXXXXXXXXXX - TURN {self.state.turn} - XXXXXXXXXXXX ")
            for _ in range(len(self.state.players)):
                p.BeginningPhase().begin(self.state)
                self.check_game_over()
                if self.game_over:
                    break

                p.MainPhase().begin(self.state)
                self.check_game_over()
                if self.game_over:
                    break

                p.CombatPhase().begin()
                self.check_game_over()
                if self.game_over:
                    break

                p.MainPhase().begin(self.state)
                self.check_game_over()
                if self.game_over:
                    break

                p.EndingPhase().begin(self.state)
                self.check_game_over()
                if self.game_over:
                    break

                self.state.pass_turn(self.state.active_player)

            self.state.turn += 1
            for player in self.state.players:
                player.reset_attrs()

    def check_game_over(self):
        for player in self.state.players:
            if player.has_lost:
                self.game_over = True
        return

        # while True:
        #     logger.debug(f"XXXXXXXXXXXX - TURN {self.state.turn} - XXXXXXXXXXXX ")
        #     for _ in range(len(self.state.players)):

        #         if BeginningPhase().start(self.state):
        #             break

        #         if MainPhase().start(self.state):
        #             break

        #         if CombatPhase().start(self.state):
        #             break

        #         if MainPhase().start(self.state):
        #             break

        #         if EndingPhase().start(self.state):
        #             break

        #         self.state.pass_turn()

        #     if self.state.check_game_over():
        #         break

        #     self.state.turn += 1
