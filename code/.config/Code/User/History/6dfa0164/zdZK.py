import pytest
import chrmndr.engine.mechanics.ability as ability
from chrmndr.models.card import Card


def test_craft(mocker, card_mock):
    to_exile = mocker.patch("chrmndr.engine.mechanics.action.exile")
    pay_craft_cost = mocker.patch("chrmndr.engine.mechanics.action.pay_craft_cost")
    transform = mocker.patch("chrmndr.engine.mechanics.action.transform")

    ability.craft(c_card=card_mock, materials=[card_mock], t_card=card_mock)

    to_exile.assert_called()
    pay_craft_cost.assert_called_once()
    transform.assert_called_once()