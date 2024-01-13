import pytest
import chrmndr.engine.mechanics.action as ability
from chrmndr.models.card import Card


def test_craft(mocker, card_mock):
    to_exile = mocker.patch("chrmndr.engine.mechanics.actions.exile")
    pay_craft_cost = mocker.patch("chrmndr.engine.mechanics.actions.pay_craft_cost")
    transform = mocker.patch("chrmndr.engine.mechanics.actions.transform")

    ability.craft(c_card=card_mock, materials=[card_mock], t_card=card_mock)

    to_exile.assert_called()
    pay_craft_cost.assert_called_once()
    transform.assert_called_once()