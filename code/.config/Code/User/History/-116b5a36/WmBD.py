import pytest
import chrmndr.engine.mechanics.action as action
from chrmndr.models.card import Card


def test_exile_single_card(mocker, card_mock):
    state = mocker.patch("chrmndr.engine.game_state")
    state.exile = []
    # pay_craft_cost = mocker.patch("chrmndr.engine.mechanics.action.pay_craft_cost")
    # transform = mocker.patch("chrmndr.engine.mechanics.action.transform")

    # ability.craft(c_card=card_mock, materials=[card_mock], t_card=card_mock)

    # to_exile.assert_called()
    # pay_craft_cost.assert_called_once()
    # transform.assert_called_once()
    pass


def test_exile_multiple_objects(mocker, card_mock):
    pass