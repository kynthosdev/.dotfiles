import pytest
import chrmndr.engine.mechanics.ability as ability
from chrmndr.models.card import Card


def test_craft(mocker, card_mock):
    to_exile = mocker.patch("chrmndr.engine.mechanics.actions.exile")

    ability.craft(card=card_mock)

    to_exile.assert_called_with(Card)