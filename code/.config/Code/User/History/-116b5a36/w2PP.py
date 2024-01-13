import pytest
from chrmndr.engine.game_state import GameState
import chrmndr.engine.mechanics.action as action
from chrmndr.models.card import Card


def test_exile_single_card(mocker, card_mock):
    state: GameState = mocker.patch("chrmndr.engine.game_state")
    state.exile_zone = []
    objects = [card_mock]

    desired = 1

    action.exile(object=card_mock)
    result = len(state.exile_zone)

    assert desired == result


def test_exile_multiple_objects(mocker, card_mock):
    pass