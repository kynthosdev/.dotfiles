import pytest
import chrmndr.engine.mechanics.action as action
from chrmndr.models.card import Card


def test_exile_single_card(mocker, card_mock):
    state = mocker.patch("chrmndr.engine.game_state")
    state.exile = []

    desired = [card_mock]
    result = []

    assert desired == result


def test_exile_multiple_objects(mocker, card_mock):
    pass