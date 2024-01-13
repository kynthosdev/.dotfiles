import pytest
from chrmndr.engine.game_state import GameState as state
import chrmndr.engine.mechanics.action as action
from chrmndr.models.card import Card


def test_exile_single_card(mocker, card_mock):
    # state: GameState = mocker.patch("chrmndr.engine.game_state")
    state.exile_zone = []
    objects = [card_mock]

    desired = 1

    action.exile(objects=objects)
    result = len(state.exile_zone)

    assert desired == result
