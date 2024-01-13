import pytest
from chrmndr.engine.phases.beginning_phase import BeginningPhase
from chrmndr.engine.phases.ending_phase import EndingPhase


def test_begining_phase_start(mocker, state_mock, beginning_phase: BeginningPhase):
    untap_step = mocker.patch(
        "chrmndr.engine.phases.beginning_phase.BeginningPhase.untap_step"
    )
    upkeep_step = mocker.patch(
        "chrmndr.engine.phases.beginning_phase.BeginningPhase.upkeep_step"
    )
    draw_step = mocker.patch(
        "chrmndr.engine.phases.beginning_phase.BeginningPhase.draw_step"
    )

    beginning_phase.begin(state_mock)

    untap_step.assert_called_once()
    upkeep_step.assert_called_once()
    draw_step.assert_called_once()


def test_ending_phase_begin(mocker, ending_phase: EndingPhase):
    end_step = mocker.patch("chrmndr.engine.phases.ending_phase.EndingPhase.end_step")
    clean_up_step = mocker.patch(
        "chrmndr.engine.phases.ending_phase.EndingPhase.clean_up_step"
    )

    ending_phase.begin()

    end_step.assert_called_once()
    clean_up_step.assert_called_once()
