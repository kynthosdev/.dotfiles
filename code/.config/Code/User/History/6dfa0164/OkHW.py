import pytest
import chrmndr.engine.mechanics.ability as ability


def test_craft(mocker):
    to_exile = mocker.patch("chrmndr.engine.mechanics.actions.exile")

    to_exile.assert_called()