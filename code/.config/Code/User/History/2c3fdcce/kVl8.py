import pytest
from chrmndr.engine.game import Game


def test_starting_game(mocker, player_mock, game: Game):
    shuffle_cards = mocker.patch("chrmndr.engine.mechanics.action.shuffle_cards")
    draw_opening_hand = mocker.patch("chrmndr.models.player.Player.draw_opening_hand")
    p1 = player_mock
    p2 = player_mock
    game.state.players = [p1, p2]

    game.starting_game()

    shuffle_cards.assert_called_with(p1.library)
    shuffle_cards.assert_called_with(p2.library)
    draw_opening_hand.assert_called()


def test_turn_structure(mocker, player_mock, state_mock, game: Game):
    state_mock.players = [player_mock]
    player_has_lost = mocker.patch("chrmndr.engine.game.Game.starting_game")

    mocker.patch("chrmndr.engine.game.Game.starting_game")
    beginning_phase_begin = mocker.patch(
        "chrmndr.engine.phases.beginning_phase.BeginningPhase.begin"
    )
    main_phase_begin = mocker.patch("chrmndr.engine.phases.main_phase.MainPhase.begin")
    combat_phase_begin = mocker.patch(
        "chrmndr.engine.phases.combat_phase.CombatPhase.begin"
    )
    ending_phase_begin = mocker.patch(
        "chrmndr.engine.phases.ending_phase.EndingPhase.begin"
    )

    game.run()

    game.starting_game.assert_called_once()
    beginning_phase_begin.assert_called_once()
    main_phase_begin.assert_called()
    combat_phase_begin.assert_called_once()
    ending_phase_begin.assert_called_once()


def test_each_player_takes_turn(mocker, player_mock, state_mock, game: Game):
    state_mock.players = [player_mock]
    beginning_phase_begin = mocker.patch(
        "chrmndr.engine.phases.beginning_phase.BeginningPhase.begin"
    )

    game.run()

    beginning_phase_begin.assert_called()


def test_player1_has_lost(state_mock, player_mock, game: Game):
    desired = True
    player_mock.has_lost = True
    state_mock.players = [player_mock]

    game.player_has_lost()

    assert desired == game.game_over


def test_player1_has_not_lost(state_mock, player_mock, game: Game):
    desired = False
    player_mock.has_lost = False
    state_mock.players = [player_mock]

    game.player_has_lost()

    assert desired == game.game_over
